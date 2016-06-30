From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 29 Jun 2016 23:38:39 -0700
Subject: [PATCH v2 00/12] gendisk: Generate uevent after attribute
 available
In-Reply-To: <20160630063554.GE23296@ad.usersys.redhat.com>
References: <20160630015953.6888-1-famz@redhat.com>
 <20160630062442.GA19761@infradead.org>
 <20160630063554.GE23296@ad.usersys.redhat.com>
Message-ID: <20160630063839.GA17205@infradead.org>

On Thu, Jun 30, 2016@02:35:54PM +0800, Fam Zheng wrote:
> also more code and less flexible IMO.  For example, we need at least two
> variants, for attribute_group and device_attribute separately, right?

Yes, or maybe just a calling convention that just passes both.
