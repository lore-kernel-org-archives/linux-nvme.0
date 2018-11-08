From: keith.busch@intel.com (Keith Busch)
Date: Thu, 8 Nov 2018 09:27:43 -0700
Subject: [PATCH] nvme: fixup ANA group descriptor offset
In-Reply-To: <BL0PR06MB4564B516DE22CB13359C73FA8CCB0@BL0PR06MB4564.namprd06.prod.outlook.com>
References: <20181105150036.17041-1-hare@suse.de>
 <BL0PR06MB4564B516DE22CB13359C73FA8CCB0@BL0PR06MB4564.namprd06.prod.outlook.com>
Message-ID: <20181108162743.GA17856@localhost.localdomain>

On Tue, Nov 06, 2018@07:02:33PM +0000, Schremmer, Steven wrote:
> > From: Linux-nvme <linux-nvme-bounces at lists.infradead.org> On Behalf Of Hannes Reinecke
> > 
> > The ANA group descriptor offset changed between the specification
> > sent for ratification and the final ratified document, causing the
> > ANA log page not to be displayed correctly.
> > 
> > Signed-off-by: Hannes Reinecke <hare at suse.com>
> > ---
> >  linux/nvme.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/linux/nvme.h b/linux/nvme.h
> > index 37d3bc1..1ad970a 100644
> > --- a/linux/nvme.h
> > +++ b/linux/nvme.h
> > @@ -546,7 +546,7 @@ struct nvme_ana_group_desc {
> >         __le32  nnsids;
> >         __le64  chgcnt;
> >         __u8    state;
> > -       __u8    rsvd17[7];
> > +       __u8    rsvd17[15];
> >         __le32  nsids[];
> >  };
> > 
> > --
> > 2.13.7
> 
> 
> Thanks, I was just getting ready to create a patch for this.
> 
> Reviewed-by: Steve Schremmer <steve.schremmer at netapp.com>

Applied, thanks!
