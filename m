From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 14 Oct 2015 00:23:03 -0700
Subject: [PATCH 2/5] block: Consolidate static integrity profile properties
In-Reply-To: <CAPcyv4it_ju8JoNcmG7K3yiKyzS_hEsNRYhiLrU1ZvqfQHjVXw@mail.gmail.com>
References: <B58D82457FDA0744A320A2FC5AC253B93CBE5758@fmsmsx104.amr.corp.intel.com>
 <1444683912-7140-1-git-send-email-martin.petersen@oracle.com>
 <1444683912-7140-3-git-send-email-martin.petersen@oracle.com>
 <CAPcyv4it_ju8JoNcmG7K3yiKyzS_hEsNRYhiLrU1ZvqfQHjVXw@mail.gmail.com>
Message-ID: <20151014072303.GA2544@infradead.org>

On Tue, Oct 13, 2015@06:11:50PM -0700, Dan Williams wrote:
> >  int nd_integrity_init(struct gendisk *disk, unsigned long meta_size)
> >  {
> > -       struct blk_integrity integrity = {
> > +       struct blk_integrity bi;
> > +       struct blk_integrity_profile profile = {
> >                 .name = "ND-PI-NOP",
> >                 .generate_fn = nd_pi_nop_generate_verify,
> >                 .verify_fn = nd_pi_nop_generate_verify,
> > -               .tuple_size = meta_size,
> > -               .tag_size = meta_size,
> 
> 'profile' here needs to be made static since we reference rather than
> copy the profile data at blk_integrity_register() time.  This is part
> of, but I don't think all of, my blk_integrity shutdown woes.

Oh, yes.  Can we also add a single noop profile to block/blk-integrity.c
while we're at it?
