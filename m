From: famz@redhat.com (Fam Zheng)
Date: Fri, 1 Jul 2016 09:01:13 +0800
Subject: [PATCH v2 00/12] gendisk: Generate uevent after attribute
 available
In-Reply-To: <20160630063839.GA17205@infradead.org>
References: <20160630015953.6888-1-famz@redhat.com>
 <20160630062442.GA19761@infradead.org>
 <20160630063554.GE23296@ad.usersys.redhat.com>
 <20160630063839.GA17205@infradead.org>
Message-ID: <20160701010113.GB10122@ad.usersys.redhat.com>

On Wed, 06/29 23:38, Christoph Hellwig wrote:
> On Thu, Jun 30, 2016@02:35:54PM +0800, Fam Zheng wrote:
> > also more code and less flexible IMO.  For example, we need at least two
> > variants, for attribute_group and device_attribute separately, right?
> 
> Yes, or maybe just a calling convention that just passes both.

OK, I can look into that, but I'm not sure about the error handling. Currently
add_disk returns void, do you have any plan on that too? should I change it in
v3 (to at least return the attribute creation failure)?

Fam
