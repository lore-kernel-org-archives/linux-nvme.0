From: nab@linux-iscsi.org (Nicholas A. Bellinger)
Date: Thu, 09 Jun 2016 23:55:07 -0700
Subject: [RFC 7/8] nvmet/admin-cmd: Hookup T10-PI to ID_NS.ms +
 ID_NS.dps feature bits
In-Reply-To: <20160609135242.GA29981@lst.de>
References: <1465281416-28355-1-git-send-email-nab@linux-iscsi.org>
 <1465281416-28355-8-git-send-email-nab@linux-iscsi.org>
 <20160609135242.GA29981@lst.de>
Message-ID: <1465541707.5365.200.camel@haakon3.risingtidesystems.com>

On Thu, 2016-06-09@15:52 +0200, Christoph Hellwig wrote:
> FYI: NVMf requires metadata to be interleaved in the data, and you
> need to indicate that in the Identify data.  Note that this is only
> a requirement for the on the wire format and for the way the Namespaces are
> exposed at the protocol level as RDMA HCA and FB HBAs should still
> be able to handle our separate SGL.

Btw, nvmet needs something similar for controller creation, like how
target_port_op works with target_alloc_session(), so hw capabilities can
signal to host controllers when PI should be enabled for a namespace,
but actual namespace backends don't support it.

Eg: TARGET_PROT_DOUT_STRIP and TARGET_PROT_DIN_INSERT ops
