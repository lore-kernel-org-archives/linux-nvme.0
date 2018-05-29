From: hch@lst.de (Christoph Hellwig)
Date: Tue, 29 May 2018 10:09:52 +0200
Subject: [PATCH 0/3] Provide more fine grained control over multipathing
In-Reply-To: <20180529072240.np5c62akbr7jqelr@linux-x5ow.site>
References: <20180525125322.15398-1-jthumshirn@suse.de>
 <20180525130535.GA24239@lst.de> <20180525135813.GB9591@redhat.com>
 <20180525141211.GA25971@lst.de> <20180525145056.GD9591@redhat.com>
 <yq1muwj45sg.fsf@oracle.com> <20180529030236.GA28895@redhat.com>
 <20180529072240.np5c62akbr7jqelr@linux-x5ow.site>
Message-ID: <20180529080952.GA1369@lst.de>

On Tue, May 29, 2018@09:22:40AM +0200, Johannes Thumshirn wrote:
> For a "Plan B" we can still use the global knob that's already in
> place (even if this reminds me so much about scsi-mq which at least we
> haven't turned on in fear of performance regressions).
> 
> Let's drop the discussion here, I don't think it leads to something
> else than flamewars.

If our plan A doesn't work we can go back to these patches.  For now
I'd rather have everyone spend their time on making Plan A work then
preparing for contingencies.  Nothing prevents anyone from using these
patches already out there if they really want to, but I'd recommend
people are very careful about doing so as you'll lock yourself into
a long-term maintainance burden.
