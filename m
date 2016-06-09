From: hch@lst.de (Christoph Hellwig)
Date: Thu, 9 Jun 2016 15:52:42 +0200
Subject: [RFC 7/8] nvmet/admin-cmd: Hookup T10-PI to ID_NS.ms +
 ID_NS.dps feature bits
In-Reply-To: <1465281416-28355-8-git-send-email-nab@linux-iscsi.org>
References: <1465281416-28355-1-git-send-email-nab@linux-iscsi.org>
 <1465281416-28355-8-git-send-email-nab@linux-iscsi.org>
Message-ID: <20160609135242.GA29981@lst.de>

FYI: NVMf requires metadata to be interleaved in the data, and you
need to indicate that in the Identify data.  Note that this is only
a requirement for the on the wire format and for the way the Namespaces are
exposed at the protocol level as RDMA HCA and FB HBAs should still
be able to handle our separate SGL.
