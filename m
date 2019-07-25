From: logang@deltatee.com (Logan Gunthorpe)
Date: Thu, 25 Jul 2019 11:23:22 -0600
Subject: [PATCH v6 03/16] chardev: export cdev_put()
In-Reply-To: <20190725172335.6825-1-logang@deltatee.com>
References: <20190725172335.6825-1-logang@deltatee.com>
Message-ID: <20190725172335.6825-4-logang@deltatee.com>

In order to use the new cdev_get_by_path() helper in a module,
cdev_put() must be exported as well.

Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
Cc: Greg Kroah-Hartman <gregkh at linuxfoundation.org>
Cc: Alexander Viro <viro at zeniv.linux.org.uk>
---
 fs/char_dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/char_dev.c b/fs/char_dev.c
index 25037d642ff8..5ab5d7da29bf 100644
--- a/fs/char_dev.c
+++ b/fs/char_dev.c
@@ -724,5 +724,6 @@ EXPORT_SYMBOL(cdev_set_parent);
 EXPORT_SYMBOL(cdev_device_add);
 EXPORT_SYMBOL(cdev_device_del);
 EXPORT_SYMBOL(cdev_get_by_path);
+EXPORT_SYMBOL(cdev_put);
 EXPORT_SYMBOL(__register_chrdev);
 EXPORT_SYMBOL(__unregister_chrdev);
-- 
2.20.1
