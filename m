From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 21 Oct 2016 06:31:38 -0700
Subject: bug in nvme_rdma module when CAP.MQES is < 128 ?
In-Reply-To: <1957614832.14672869.1477055311936.JavaMail.zimbra@kalray.eu>
References: <1957614832.14672869.1477055311936.JavaMail.zimbra@kalray.eu>
Message-ID: <20161021133138.GA16449@infradead.org>

Hi Samuel,

the analysis seems sensible.  We'll defintively want to keep the MAXCMDS
check, so SQSIZE would be in addition.  Can you send a patch to
implement it?
