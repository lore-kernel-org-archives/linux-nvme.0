From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 9 Nov 2015 07:48:37 -0800
Subject: [PATCH v2] NVMe:Expose model attribute in sysfs
In-Reply-To: <20151109154349.GA4735@localhost.localdomain>
References: <20150909062713.GA14279@localhost.localdomain>
 <20150915202603.GA3619@localhost.localdomain>
 <20151109154349.GA4735@localhost.localdomain>
Message-ID: <20151109154837.GA2242@infradead.org>

On Mon, Nov 09, 2015@03:43:49PM +0000, Keith Busch wrote:
> Yes, I'd like to see this included. It will make it easier to add new
> attributes to help the systemd developers[1] identify nvme controllers
> and their namespaces.
> 
>  [1]  https://github.com/systemd/systemd/issues/1453


FYI, I think using the serial number for this purpose is broken.  We
need a per-namespace identifier for a stable block device name, i.e. the
NGUID.
