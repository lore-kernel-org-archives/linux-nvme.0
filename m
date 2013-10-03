From: jackm@dev.mellanox.co.il (Jack Morgenstein)
Date: Thu, 3 Oct 2013 19:11:00 +0300
Subject: [PATCH RFC 51/77] mthca: Update MSI/MSI-X interrupts enablement
 code
In-Reply-To: <9d424912ef78993dc75e2af5006cd12913e9e7e7.1380703263.git.agordeev@redhat.com>
References: <cover.1380703262.git.agordeev@redhat.com>
 <9d424912ef78993dc75e2af5006cd12913e9e7e7.1380703263.git.agordeev@redhat.com>
Message-ID: <20131003191100.3e3e3bfd@jpm-OptiPlex-GX620>

On Wed,  2 Oct 2013 12:49:07 +0200
Alexander Gordeev <agordeev@redhat.com> wrote:

> Subject: [PATCH RFC 51/77] mthca: Update MSI/MSI-X interrupts
> enablement code Date: Wed,  2 Oct 2013 12:49:07 +0200
> Sender: linux-rdma-owner at vger.kernel.org
> X-Mailer: git-send-email 1.7.7.6
> 
> As result of recent re-design of the MSI/MSI-X interrupts enabling
> pattern this driver has to be updated to use the new technique to
> obtain a optimal number of MSI/MSI-X interrupts required.
> 
> Signed-off-by: Alexander Gordeev <agordeev at redhat.com>
> ---

ACK.

-Jack
