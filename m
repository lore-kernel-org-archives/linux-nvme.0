From: selvin.xavier@broadcom.com (Selvin Xavier)
Date: Sat, 13 Jul 2019 13:21:54 +0530
Subject: regression: nvme rdma with bnxt_re0 broken
In-Reply-To: <20190712174220.GL27512@ziepe.ca>
References: <66d43fd8-18e8-8b9d-90e3-ee2804d56889@redhat.com>
 <AM0PR05MB4866DEDB9DE4379F6A6EF15BD1F20@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <CA+sbYW17PGAW57pyRmQB9KsDA9Q+7FFgSseSTTWE_h6vffa7UQ@mail.gmail.com>
 <AM0PR05MB4866CFEDCDF3CDA1D7D18AA5D1F20@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <AM0PR05MB4866CCD487C9D99BD9526BA8D1F20@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <AM0PR05MB4866665D5CACB34AE885BCA2D1F20@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <ef6a01a1-9163-ef4e-29ac-4f4130c682f1@redhat.com>
 <AM0PR05MB48666463325E1D0E25D63F57D1F20@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <20190712154044.GJ27512@ziepe.ca>
 <CA+sbYW0F6Vgpa5SQX+9ge4EwWrMkJ4kQ-psEq11S00=-L_mVhg@mail.gmail.com>
 <20190712174220.GL27512@ziepe.ca>
Message-ID: <CA+sbYW3Pp=qwky+myAEkiP-9TOui+9=DSyQxivNuSEsD8K4CFA@mail.gmail.com>

On Fri, Jul 12, 2019@11:12 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Fri, Jul 12, 2019@09:59:38PM +0530, Selvin Xavier wrote:
>
> > > bnxt guys: please just delete this duplicate detection code from the
> > > driver. Every GID provided from the core must be programmed into the
> > > given gid table index.
> >
> > Jason,
> >  This check is required in bnxt_re because the HW need only one entry
> > in its table for RoCE V1 and RoCE v2 Gids.
>
> The HW doesn't have a 'GID table' if it has this restriction. It
> sounds like it has some 'IP table' or maybe 'IP and VLAN' table?
>
> So the driver must provide a full emulated 'GID Table' with all the
> normal semantics.
>
> Which looks sort of like what the add side is doing, other than the
> mis-naming it seems reasonable..
>
> But then I see this in re_create_ah:
>
>         /*
>          * If RoCE V2 is enabled, stack will have two entries for
>          * each GID entry. Avoiding this duplicte entry in HW. Dividing
>          * the GID index by 2 for RoCE V2
>          */
>         ah->qplib_ah.sgid_index = grh->sgid_index / 2;
>
> Which seems completely wrong - that is making assumptions about the
> layout of the gid table that is just not allowed.
>
> Surely it needs to access the per-gid driver context that add_gid set
> and use the index into the sgid_table from there?
>
Agree.. We need a mapping between HW table index and GID table index.
We can either maintain a mapping in the driver or have an ib stack function to
get the per gid driver context from gid table index. The later makes sense
only if other drivers also needs such interface.  I am not sure any
other driver needs
it.
