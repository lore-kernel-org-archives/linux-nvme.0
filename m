From: hch@lst.de (hch@lst.de)
Date: Tue, 11 Dec 2018 15:15:47 +0100
Subject: [PATCH 10/12] nvmet: add error log support for admin-cmd
In-Reply-To: <BYAPR04MB4502206C5362955EF2F2014686A50@BYAPR04MB4502.namprd04.prod.outlook.com>
References: <20181210055011.3146-1-chaitanya.kulkarni@wdc.com>
 <BYAPR04MB4502206C5362955EF2F2014686A50@BYAPR04MB4502.namprd04.prod.outlook.com>
Message-ID: <20181211141547.GA8591@lst.de>

On Mon, Dec 10, 2018@10:55:08PM +0000, Chaitanya Kulkarni wrote:
> I'm wandering how we can guarantee that we don't forget to set
> req->error_loc for all future errors...
> 
> Anyways..
> 
> [CK] One way to do that is to have a default centralized mapping from the error codes,
> not sure if that is worth an effort though, will skip this for now.

Well, the M bit and the error log page are optional features.
Maybe we should only set the M bit and generate a log page if error_loc
is set?  Although for that we'd need to initialize it to -1 as 0
is a valid error location.

We could then also add a debug option to print a warning for errors
without error_loc if we care enough.
