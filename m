From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 6 Jun 2017 09:15:39 +0200
Subject: [PATCH V2] nvme: fix multiple ctrl removal scheduling
In-Reply-To: <20170605114309.GA31824@dhcp-216.srv.tuxera.com>
References: <20170605114309.GA31824@dhcp-216.srv.tuxera.com>
Message-ID: <20170606071539.2t2tks3zchtwzxcq@infradead.org>

Thanks, applied to nvme-4.12 after fixing up the changelog, and
adding back the (now slightly modified) WARN_ON for a wrong state
in nvme_reset_work.
