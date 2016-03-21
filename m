From: hch@lst.de (Christoph Hellwig)
Date: Mon, 21 Mar 2016 15:38:35 +0100
Subject: [PATCH] NVMe Add Support for Solid State Media Log Page
In-Reply-To: <20160318181946.GG23727@linux.intel.com>
References: <BL2PR04MB16375598B6306A175B683CD928C0@BL2PR04MB163.namprd04.prod.outlook.com>
 <20160318165616.GC13054@localhost.localdomain>
 <CEB583F6-A646-49CE-ABFE-06086479C61E@hgst.com>
 <20160318181946.GG23727@linux.intel.com>
Message-ID: <20160321143835.GA12720@lst.de>

On Fri, Mar 18, 2016@02:19:46PM -0400, Matthew Wilcox wrote:
> On Fri, Mar 18, 2016@06:04:06PM +0000, David Darrington wrote:
> > This was a customer request. I?ll check to see if they are aware that the component will no longer be supported.
> 
> "will no longer be supported" is Christoph's idea.  I think there are far
> more users of this feature than he realises, and distros will continue
> to enable it.  Much as we might want to get rid of it ...

I kept it around as a non-default to not break existing users.  But
I don't think we should add new feature to it.  I think we should
have a usespace library that application can use instead.  Any chance
we could the original Intel code for the translation licensed under
a permissive license for it?  It know very similar code it available
under a BSD license for the Windows driver, but it it would take a
while to clean it up..
