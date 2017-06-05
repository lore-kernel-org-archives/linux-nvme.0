From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 5 Jun 2017 10:44:54 -0700
Subject: [PATCH] nvme: TUR(Test unit Ready) broken for nvme drvices
In-Reply-To: <1496677172-22797-1-git-send-email-wenxiong@linux.vnet.ibm.com>
References: <1496677172-22797-1-git-send-email-wenxiong@linux.vnet.ibm.com>
Message-ID: <20170605174454.GA5432@infradead.org>

Given how broken the emulation was we should simply remove it.
