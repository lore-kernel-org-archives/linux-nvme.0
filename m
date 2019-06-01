From: hch@lst.de (Christoph Hellwig)
Date: Sat, 1 Jun 2019 11:02:38 +0200
Subject: [PATCH v3 2/3] nvme: add thermal zone devices
In-Reply-To: <1558888143-5121-3-git-send-email-akinobu.mita@gmail.com>
References: <1558888143-5121-1-git-send-email-akinobu.mita@gmail.com>
 <1558888143-5121-3-git-send-email-akinobu.mita@gmail.com>
Message-ID: <20190601090238.GD6453@lst.de>

On Mon, May 27, 2019@01:29:02AM +0900, Akinobu Mita wrote:
> The NVMe controller reports up to nine temperature values in the SMART /
> Health log page (the composite temperature and temperature sensor 1 through
> temperature sensor 8).
> 
> This provides these temperatures via thermal zone devices.

Can you explain a bit more why we'd do this?  I shows up some sysfs
files, but we could easily do that with nvme-cli, too.  Is there some
greater benefit of this integration?
