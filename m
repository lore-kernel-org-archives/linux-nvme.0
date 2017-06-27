From: keith.busch@intel.com (Keith Busch)
Date: Tue, 27 Jun 2017 15:47:53 -0400
Subject: [PATCH] nvme: remove indenty ctrl before scan namespace
In-Reply-To: <20170627152336.GA36545@localhost.didichuxing.com>
References: <20170627152336.GA36545@localhost.didichuxing.com>
Message-ID: <20170627194753.GC23962@localhost.localdomain>

On Tue, Jun 27, 2017@11:23:36PM +0800, weiping zhang wrote:
> All nvme host drivers have already identified ctrl beforce scan namespace,
> so when first time identify ctrl we get the number of namespace and store it
> into nvme_ctrl. When we scan namespace just use it instead of indentify again.

The scan work can be schedule in more than just the reset path, though,
which is where ID ctrl is initialized. In those cases, attaching
namespaces may stop working.
