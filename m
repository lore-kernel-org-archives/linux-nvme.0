From: hch@lst.de (Christoph Hellwig)
Date: Wed, 13 Jun 2018 13:26:31 +0200
Subject: [PATCH 08/12] nvmet: mask pending AERs
In-Reply-To: <c989fd6b-eda4-75ec-a670-4b78b0b68f98@mellanox.com>
References: <20180530164600.26856-1-hch@lst.de>
 <20180530164600.26856-9-hch@lst.de>
 <b0427eb1-5bba-4c2b-c7fd-8df3b6dad2cf@mellanox.com>
 <20180613074225.GA22725@lst.de>
 <c989fd6b-eda4-75ec-a670-4b78b0b68f98@mellanox.com>
Message-ID: <20180613112631.GA27314@lst.de>

On Wed, Jun 13, 2018@11:23:15AM +0300, Max Gurtovoy wrote:
> This is not an easy task, I guess, for distros or other SW packeges out 
> there...
> Currently all of them can't work with upstream target :(

You'll just need to rescan manually.
