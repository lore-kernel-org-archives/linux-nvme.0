From: zouming.zouming@huawei.com (Zouming (IT))
Date: Fri, 28 Apr 2017 02:12:55 +0000
Subject: =?gb2312?B?tPC4tDogW1BBVENIXSBudm1lLWNsaTogSHVhd2VpIHBsdWctaW4u?=
In-Reply-To: <20170427153515.GB20859@localhost.localdomain>
References: <1493280301-19648-1-git-send-email-zouming.zouming@huawei.com>
 <20170427153515.GB20859@localhost.localdomain>
Message-ID: <32770656ECCC174D9F733890F5D00C0D994751AD@dggemm511-mbx.china.huawei.com>

hi,Keith

Thanks a lot for your reivew.
We will continue to enhance the Huawei plug-in.

Best wishes,
Zou Ming, Philip Yang

-----????-----
???: Keith Busch [mailto:keith.busch at intel.com] 
????: 2017?4?27? 23:35
???: Zouming (IT) <zouming.zouming at huawei.com>
??: linux-nvme at lists.infradead.org; guanjunxiong <guanjunxiong at huawei.com>; Yangfeng (B) <philip.yang at huawei.com>; Shenhong (C) <shenhong09 at huawei.com>; Hege (A) <hege09 at huawei.com>; Qiuxin (robert) <qiuxin at huawei.com>
??: Re: [PATCH] nvme-cli: Huawei plug-in.

On Thu, Apr 27, 2017@08:05:01AM +0000, Zou Ming wrote:
> This patch adds support for Vendor unique commands for Huawei devices.
> Following commands are supported in current version of this extension:
> 
> 1.list  List addition info (such as namespace name and array name) for 
> Huawei devices

Looks fine. You may want to add a vendor specific id-ns and id-ctrl to decode those VS bits for individual namespaces and controllers beyond the full list, but this is a start.

I fixed up some of the formatting and applied. Thanks!
