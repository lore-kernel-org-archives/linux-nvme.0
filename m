From: hch@lst.de (Christoph Hellwig)
Date: Mon, 2 Jul 2018 15:07:28 +0200
Subject: [PATCH 1/2] nvme-pci: remove whitespace
In-Reply-To: <aaa460e43cb43efbfb902d0aa844a1da9ed270dc.1530457943.git.zhangweiping@didichuxing.com>
References: <cover.1530457943.git.zhangweiping@didichuxing.com>
 <aaa460e43cb43efbfb902d0aa844a1da9ed270dc.1530457943.git.zhangweiping@didichuxing.com>
Message-ID: <20180702130728.GA4624@lst.de>

Please, no whitespace cleanups before critical patches.

Also both styles in this case are acceptable in the kernel.  I
personally prefer to not have space, but we really shouldn't spuriously
change it.
