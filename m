From: willy@linux.intel.com (Matthew Wilcox)
Date: Tue, 2 Dec 2014 16:32:44 -0500
Subject: [PATCH] NVMe: Update SCSI Inquiry VPD 83 translation
In-Reply-To: <CANvN+emyvT5MEsyOmY2XG=4j4Yq+Hp93oEtyXbooGp9qJWNfTw@mail.gmail.com>
References: <1417550176-14775-1-git-send-email-keith.busch@intel.com>
 <20141202205015.GW11522@wil.cx>
 <CANvN+emyvT5MEsyOmY2XG=4j4Yq+Hp93oEtyXbooGp9qJWNfTw@mail.gmail.com>
Message-ID: <20141202213244.GX11522@wil.cx>

On Tue, Dec 02, 2014@11:57:50PM +0300, Andrey Kuzmin wrote:
> On Dec 2, 2014 11:51 PM, "Matthew Wilcox" <willy@linux.intel.com> wrote:
> >
> > On Tue, Dec 02, 2014@12:56:16PM -0700, Keith Busch wrote:
> > > +     if (readl(&dev->bar->vs) >= 0x10100) {
> >
> > I think we want an NVME_VERSION() macro that maybe looks something like
> this:
> >
> > #define NVME_VERSION(major, minor) (((major) << 16) | ((minor) << 8))
> >
> > Then you can make this:
> >
> >         if (readl(&dev->bar->vs) >= NVME_VERSION(1, 1))
> 
> Adding #define for NVME_VERSION_MAJOR/MINOR would make it easier to
> maintain than (1,1).

I don't quite understand what you're arguing for.  Could you demonstrate?
