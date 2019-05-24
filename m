From: kbusch@kernel.org (Keith Busch)
Date: Fri, 24 May 2019 08:45:33 -0600
Subject: [PATCH 0/2] nvme-cli: fix disconnect-all for pcie tp
In-Reply-To: <20190516172350.11864-1-minwoo.im.dev@gmail.com>
References: <20190516172350.11864-1-minwoo.im.dev@gmail.com>
Message-ID: <20190524144532.GD15192@localhost.localdomain>

On Thu, May 16, 2019@10:23:48AM -0700, Minwoo Im wrote:
> The first patch fixes that it tries to delete_controller even it's a
> controller with PCIe transport type.  If so, the rest of the controller
> with fabrics type might not be disconnected properly.
> 
> The second one is just a trivial clean-up patch.

Thanks, added with Sagi and Chaitanya's reviews.
