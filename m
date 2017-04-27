From: keith.busch@intel.com (Keith Busch)
Date: Thu, 27 Apr 2017 11:35:16 -0400
Subject: [PATCH] nvme-cli: Huawei plug-in.
In-Reply-To: <1493280301-19648-1-git-send-email-zouming.zouming@huawei.com>
References: <1493280301-19648-1-git-send-email-zouming.zouming@huawei.com>
Message-ID: <20170427153515.GB20859@localhost.localdomain>

On Thu, Apr 27, 2017@08:05:01AM +0000, Zou Ming wrote:
> This patch adds support for Vendor unique commands for Huawei devices.
> Following commands are supported in current version of this extension:
> 
> 1.list  List addition info (such as namespace name and array name) for Huawei devices

Looks fine. You may want to add a vendor specific id-ns and id-ctrl to
decode those VS bits for individual namespaces and controllers beyond
the full list, but this is a start.

I fixed up some of the formatting and applied. Thanks!
