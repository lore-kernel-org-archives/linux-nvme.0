From: hch@lst.de (Christoph Hellwig)
Date: Sat, 1 Jun 2019 11:03:53 +0200
Subject: [PATCH v3 3/3] nvme: notify thermal framework when temperature
 threshold events occur
In-Reply-To: <1558888143-5121-4-git-send-email-akinobu.mita@gmail.com>
References: <1558888143-5121-1-git-send-email-akinobu.mita@gmail.com>
 <1558888143-5121-4-git-send-email-akinobu.mita@gmail.com>
Message-ID: <20190601090353.GE6453@lst.de>

So before we allowed userspace to get smart AEN notifications through
uevent, and would expect userspace to clear the AEN.  I think this
could at least potentially break existing userspace by now doing that
in kernel space.
