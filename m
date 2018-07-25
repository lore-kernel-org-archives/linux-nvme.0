From: hch@lst.de (Christoph Hellwig)
Date: Wed, 25 Jul 2018 06:58:03 +0200
Subject: [PATCH 2/9] nvme.h: add ANA definitions
In-Reply-To: <BYAPR04MB4502926670E37116CB7B6BEF86540@BYAPR04MB4502.namprd04.prod.outlook.com>
References: <20180724115009.731-3-hch@lst.de>
 <BYAPR04MB4502926670E37116CB7B6BEF86540@BYAPR04MB4502.namprd04.prod.outlook.com>
Message-ID: <20180725045803.GB10905@lst.de>

> +struct nvme_ana_group_desc {
> +?????? __le32? grpid;
> +?????? __le32? nnsids;
> +?????? __le64? chgcnt;
> +?????? __u8??? state;
> +?????? __u8??? rsvd17[7];
> 
> [CK] From Figure 52a: ANA Group Descriptor format:-
> 
> 31:17: Reserved.
> 
> 35:32: Namespace Identifier 0: The Namespace Identifier of the first namespace that is a member of
> this ANA Group.
> 
> So we have to change the Index of rsvd17 to 15?

The reserved fields in nvme are usually named after the index where they
start, not their length.  This reserved spae is at byte 17, so I think
we are ok.
