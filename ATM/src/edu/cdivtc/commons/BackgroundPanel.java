package edu.cdivtc.commons;

import javax.imageio.ImageIO;
import javax.swing.*;
import java.awt.*;
import java.io.File;
import java.io.IOException;

public class BackgroundPanel extends JPanel {
    private Image backgroundImage;
    private Color bgColor;

    /**
     * 创建带背景图片的面板（图片自适应缩放填满面板）
     */
    public BackgroundPanel(String imgUrl) {
        try {
            File imgFile = new File(imgUrl);
            if (imgFile.exists()) {
                backgroundImage = ImageIO.read(imgFile);
                if (backgroundImage == null) {
                    System.err.println("无法解码图片: " + imgUrl);
                }
            } else {
                System.err.println("图片文件不存在: " + imgFile.getAbsolutePath());
            }
        } catch (IOException e) {
            System.err.println("加载图片失败: " + imgUrl);
            backgroundImage = null;
        }
        setLayout(null);
        setOpaque(true);
    }

    /**
     * 创建纯色背景面板
     */
    public BackgroundPanel(Color color) {
        this.bgColor = color;
        setLayout(null);
        setOpaque(true);
    }

    @Override
    protected void paintComponent(Graphics g) {
        Graphics2D g2 = (Graphics2D) g.create();
        g2.setRenderingHint(RenderingHints.KEY_RENDERING, RenderingHints.VALUE_RENDER_QUALITY);
        g2.setRenderingHint(RenderingHints.KEY_INTERPOLATION, RenderingHints.VALUE_INTERPOLATION_BILINEAR);

        if (backgroundImage != null) {
            g2.drawImage(backgroundImage, 0, 0, getWidth(), getHeight(), this);
        } else if (bgColor != null) {
            g2.setColor(bgColor);
            g2.fillRect(0, 0, getWidth(), getHeight());
        } else {
            super.paintComponent(g);
        }

        g2.dispose();
    }
}
