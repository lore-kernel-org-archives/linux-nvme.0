From: logang@deltatee.com (Logan Gunthorpe)
Date: Mon, 23 Apr 2018 17:30:37 -0600
Subject: [PATCH v4 05/14] docs-rst: Add a new directory for PCI documentation
In-Reply-To: <20180423233046.21476-1-logang@deltatee.com>
References: <20180423233046.21476-1-logang@deltatee.com>
Message-ID: <20180423233046.21476-6-logang@deltatee.com>

Add a new directory in the driver API guide for PCI specific
documentation.

This is in preparation for adding a new PCI P2P DMA driver writers
guide which will go in this directory.

Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
Cc: Jonathan Corbet <corbet at lwn.net>
Cc: Mauro Carvalho Chehab <mchehab at kernel.org>
Cc: Greg Kroah-Hartman <gregkh at linuxfoundation.org>
Cc: Vinod Koul <vinod.koul at intel.com>
Cc: Linus Walleij <linus.walleij at linaro.org>
Cc: Logan Gunthorpe <logang at deltatee.com>
Cc: Thierry Reding <treding at nvidia.com>
Cc: Sanyog Kale <sanyog.r.kale at intel.com>
Cc: Sagar Dharia <sdharia at codeaurora.org>
---
 Documentation/driver-api/index.rst         |  2 +-
 Documentation/driver-api/pci/index.rst     | 19 +++++++++++++++++++
 Documentation/driver-api/{ => pci}/pci.rst |  0
 3 files changed, 20 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/driver-api/pci/index.rst
 rename Documentation/driver-api/{ => pci}/pci.rst (100%)

diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index 6d8352c0f354..9e4cd4e91a49 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -27,7 +27,7 @@ available subsections can be seen below.
    iio/index
    input
    usb/index
-   pci
+   pci/index
    spi
    i2c
    hsi
diff --git a/Documentation/driver-api/pci/index.rst b/Documentation/driver-api/pci/index.rst
new file mode 100644
index 000000000000..03b57cbf8cc2
--- /dev/null
+++ b/Documentation/driver-api/pci/index.rst
@@ -0,0 +1,19 @@
+============================================
+The Linux PCI driver implementer's API guide
+============================================
+
+.. class:: toc-title
+
+	   Table of contents
+
+.. toctree::
+   :maxdepth: 2
+
+   pci
+
+.. only::  subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
diff --git a/Documentation/driver-api/pci.rst b/Documentation/driver-api/pci/pci.rst
similarity index 100%
rename from Documentation/driver-api/pci.rst
rename to Documentation/driver-api/pci/pci.rst
-- 
2.11.0
