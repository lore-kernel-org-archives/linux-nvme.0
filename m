From: keith.busch@intel.com (Keith Busch)
Date: Mon, 12 Feb 2018 07:18:19 -0700
Subject: [PATCH 1/3] nvme-pci: Fix timeouts in connecting state
In-Reply-To: <ec9b47c4-3c83-6f00-bf2d-8eae5484a649@oracle.com>
References: <20180209174127.7224-1-keith.busch@intel.com>
 <ec9b47c4-3c83-6f00-bf2d-8eae5484a649@oracle.com>
Message-ID: <20180212141818.GA16255@localhost.localdomain>

On Sat, Feb 10, 2018@10:14:46AM +0800, jianchao.wang wrote:
> This patch should be merged with the 3th one.

Why? This one fixes a regression introduced in the merge window, the
other is fixes something entirely different.
