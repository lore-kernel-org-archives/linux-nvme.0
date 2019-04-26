From: aaron.ma@canonical.com (Aaron Ma)
Date: Fri, 26 Apr 2019 13:27:51 +0800
Subject: [PATCH] nvme: determine the number of IO queues
In-Reply-To: <20190425143902.GA30715@infradead.org>
References: <1555510379-20199-1-git-send-email-aaron.ma@canonical.com>
 <a2f0a97e14b884dc1183db9cbdd6f4b520000ce3.camel@redhat.com>
 <096935354b16662eb481aeda1f48001ba489463c.camel@redhat.com>
 <e79703d5-3502-6519-a497-71b2b2a8768f@canonical.com>
 <20190418134820.GA7589@localhost.localdomain>
 <ddabda2a-b30d-77cc-7b2e-05a6b599cae7@canonical.com>
 <20190425143902.GA30715@infradead.org>
Message-ID: <edb9019a-4ff4-2289-878b-76543f639c1c@canonical.com>


On 4/25/19 10:39 PM, Christoph Hellwig wrote:
> Honestly, unless this is a device shiping in a max market consumer
> product already I don't think we should work around this crap at all,
> given that this device has obviously never been tested at all.  It
> really needs a firmware fix instead of a host workaround.


Already pushed this issue to firmware eng team.
They will try to fix it.
As far as I know we don't need this host workaround.

Thanks,
Aaron
