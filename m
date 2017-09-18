From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 18 Sep 2017 16:17:15 -0700
Subject: [PATCH v3 3/3] nvme_fc: Avoid duplicate associations between
 same port pairs
In-Reply-To: <7f610102-562c-18e0-659a-ff06b0186ac2@broadcom.com>
References: <20170914173843.3195-1-jsmart2021@gmail.com>
 <20170914173843.3195-4-jsmart2021@gmail.com>
 <20170918161219.GB310@infradead.org>
 <7f610102-562c-18e0-659a-ff06b0186ac2@broadcom.com>
Message-ID: <20170918231715.GB12410@infradead.org>

On Mon, Sep 18, 2017@09:28:35AM -0700, James Smart wrote:
> The desire for FC is to have the same dynamic discovery that it has for
> SCSI. Thus the udev events that kick off scanning. The events are posted
> when connectivity is first detected as well as conditions where the
> discovery server content may have changed (new subsystems added for
> example).? Since those events are ignorant of what's already connected, it
> make no sense to create additional controllers/devices if there's already a
> controller connected.
> 
> The alternative is to drive all connections manually which makes a very
> difficult to manage system for an administrator, especially on "cable-pull"
> scenarios. There is no need for this with FC.

The add a connect options that checks for duplicates instead of making
it the only options.  And please make it a global check for all
fabrics transports.
