From: willy@linux.intel.com (Matthew Wilcox)
Date: Fri, 18 Mar 2016 14:19:46 -0400
Subject: [PATCH] NVMe Add Support for Solid State Media Log Page
In-Reply-To: <CEB583F6-A646-49CE-ABFE-06086479C61E@hgst.com>
References: <BL2PR04MB16375598B6306A175B683CD928C0@BL2PR04MB163.namprd04.prod.outlook.com>
 <20160318165616.GC13054@localhost.localdomain>
 <CEB583F6-A646-49CE-ABFE-06086479C61E@hgst.com>
Message-ID: <20160318181946.GG23727@linux.intel.com>

On Fri, Mar 18, 2016@06:04:06PM +0000, David Darrington wrote:
> This was a customer request. I?ll check to see if they are aware that the component will no longer be supported.

"will no longer be supported" is Christoph's idea.  I think there are far
more users of this feature than he realises, and distros will continue
to enable it.  Much as we might want to get rid of it ...

> On 3/18/16, 11:56 AM, "Keith Busch" <keith.busch@intel.com> wrote:
> 
> >The translation itself looks fine, but are we applying new SCSI
> >translations upstream anymore? The entire component is disabled by
> >default, I believe with the intention of removing it in the future.
> >
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
