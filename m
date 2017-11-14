From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 13 Nov 2017 21:50:05 -0800
Subject: FW: [PATCH 1/2] NVMe-CLI : WDC-Plugin Updated Smart Log Commands
In-Reply-To: <MWHPR04MB10258A34FE2D489A71A224F2EA2B0@MWHPR04MB1025.namprd04.prod.outlook.com>
References: <20171108164947.28987-1-jeff.lien@wdc.com>
 <20171108170323.GB25017@localhost.localdomain>
 <MWHPR04MB10258A34FE2D489A71A224F2EA2B0@MWHPR04MB1025.namprd04.prod.outlook.com>
Message-ID: <20171114055005.GA30668@infradead.org>

We either need to add the vs-* prefix for all plugin commands or none,
we can't be selective.

Also you must not add two different vendor specific smart log pages,
existing users expect the command to do the right thing.  Please check
inside the plugin which hardware you are talking to to and issue the
call for the right log page.
