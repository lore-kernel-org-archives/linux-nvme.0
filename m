From: keith.busch@intel.com (Keith Busch)
Date: Thu, 19 Oct 2017 09:48:22 -0600
Subject: [PATCH V7] nvme-pci: add SGL support
In-Reply-To: <20171019102847.GA6828@infradead.org>
References: <1508203460-13852-1-git-send-email-ckulkarnilinux@gmail.com>
 <20171019102847.GA6828@infradead.org>
Message-ID: <20171019154821.GD2768@localhost.localdomain>

Yeah, I don't have any major concerns. I was hung up on the
tagset.cmd_size being smaller when SGL's are used, but it took me a
minute to determine that's okay as we were overallocating it before.

The criteria used to select sgl usage makes sense, so good to go on my
end.

Reviewed-by: Keith Busch <keith.busch at intel.com>
