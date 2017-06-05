From: hch@lst.de (Christoph Hellwig)
Date: Mon, 5 Jun 2017 07:35:45 +0200
Subject: [PATCH v4 3/8] nvmet: implement namespace identify descriptor list
In-Reply-To: <20170604103649.22130-4-jthumshirn@suse.de>
References: <20170604103649.22130-1-jthumshirn@suse.de>
 <20170604103649.22130-4-jthumshirn@suse.de>
Message-ID: <20170605053545.GD19480@lst.de>

I think this needs to zero the remainder of the 4k
buffer, quoting the spec:

"The controller may return any number of variable length Namespace
Identification Descriptor structures that fit into the 4096 byte Identify
payload. All remaining bytes after the namespace identification descriptor
structures should be cleared to 0h, and the host shall interpret a
Namespace Identifier Descriptor Length (NIDL) value of 0h as the end of
the list. If the hosts sees an unknown descriptor type it should
continue parsing the structure."

It could be easily done by copying the zero page to userspace.
Eventually I want to add a helper to zero parts of a sglist to
lib/scatterlist.c, but I don't want to burden that on you.
