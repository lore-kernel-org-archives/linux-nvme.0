Return-Path: <SRS0=IF7s=7D=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A338C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 21 May 2020 09:35:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D3322072C
	for <linux-nvme@archiver.kernel.org>; Thu, 21 May 2020 09:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bpZs4txJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D3322072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1KrEbuUpRUw83gDSFUMQTc6x6JreGyMIUJhGMHVlrxc=; b=bpZs4txJcHKXiZ
	lVRdRFknwdoCAORZekzqMm0j5zGlXG7yz+xDSu9QKBgEaNGqkoykexz1ejZgeSRRzWnfVAHZeABlJ
	F+PP5buRkTlgFzvFE8kyC6OxkuvmOCzhwpFWxds/TiGLQMUCHgvlv/wjOtW+d7pnbR79NtjSg7ddx
	YC+nXvx9I0mYechcz4YRRc1aAqz9e5cOx+fvEovci9ftAF59Yh8qwXTleFWXUx4hHPzLblJdOUuF8
	pGBAUQEeemu+PRXyMqxqXk0ww/LgoIOWiBtJDJfZwcDGmrFCgogcfQYEEPezUy23/D8JEVlXHkxvd
	4mVEcuz3eNNd+m//hygA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jbhbO-0007sW-2b; Thu, 21 May 2020 09:34:58 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jbhbL-0007s4-K6
 for linux-nvme@lists.infradead.org; Thu, 21 May 2020 09:34:57 +0000
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 21F4D12E8B6A23AB3AF9;
 Thu, 21 May 2020 17:34:46 +0800 (CST)
Received: from [127.0.0.1] (10.74.203.66) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Thu, 21 May 2020
 17:34:36 +0800
Subject: Re: [PATCH nvme-cli] edit huawei ssd filter
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, "kbusch@kernel.org"
 <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
References: <20200520013922.101374-1-liuzhouhua@huawei.com>
 <BYAPR04MB496503E2EB0863F2C69CB2AC86B60@BYAPR04MB4965.namprd04.prod.outlook.com>
From: Zhouhua Liu <liuzhouhua@huawei.com>
Message-ID: <6f5a1e9e-a3f8-3653-56c6-4e71ddc26a2d@huawei.com>
Date: Thu, 21 May 2020 17:34:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB496503E2EB0863F2C69CB2AC86B60@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [10.74.203.66]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200521_023455_824456_E784B604 
X-CRM114-Status: GOOD (  17.46  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: wangzan <wangzan@huawei.com>, Kangwenhong <kangwenhong@huawei.com>,
 "Wangchong \(Michael\)" <Michael.wangchong@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Chaitanya,

thank you for your suggestion, the new patch is blow:

Signed-off-by: Zhouhua Liu <liuzhouhua@huawei.com>
---
 plugins/huawei/huawei-nvme.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/plugins/huawei/huawei-nvme.c b/plugins/huawei/huawei-nvme.c
index c935f47..b4aef1e 100644
--- a/plugins/huawei/huawei-nvme.c
+++ b/plugins/huawei/huawei-nvme.c
@@ -41,6 +41,7 @@
 #define CREATE_CMD
 #include "huawei-nvme.h"

+#define HW_SSD_PCI_VENDOR_ID 0x19E5
 #define ARRAY_NAME_LEN 80
 #define NS_NAME_LEN    40

@@ -80,16 +81,15 @@ static int huawei_get_nvme_info(int fd, struct huawei_list_item *item, const cha
                return err;

        /*identify huawei device*/
-       if (strstr(item->ctrl.mn, "Huawei") == NULL) {
+       if ((strstr(item->ctrl.mn, "Huawei") == NULL) &&
+               (le16_to_cpu(item->ctrl.vid) != HW_SSD_PCI_VENDOR_ID)) {
                item->huawei_device = false;
                return 0;
        }
-       else
-               item->huawei_device = true;

+       item->huawei_device = true;
        item->nsid = nvme_get_nsid(fd);
-       err = nvme_identify_ns(fd, item->nsid,
-                                                       0, &item->ns);
+       err = nvme_identify_ns(fd, item->nsid, 0, &item->ns);
        if (err)
                return err;

--
2.22.0


On 2020/5/20 16:04, Chaitanya Kulkarni wrote:
> On 5/19/20 6:47 PM, l00293085 wrote:
>> Hi, I'd like to modify command: nvme huawei list, add huawei vendor id as filter
>>
> Please modify the subject line and patch description as per the style 
> present in the tree.
>> Signed-off-by: Andy Liu <liuzhouhua@huawei.com>
>> Reviewed-by: Wang Zan <wangzan@huawei.com>
>> ---
>>   plugins/huawei/huawei-nvme.c | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/plugins/huawei/huawei-nvme.c b/plugins/huawei/huawei-nvme.c
>> index c935f47..c7f3307 100644
>> --- a/plugins/huawei/huawei-nvme.c
>> +++ b/plugins/huawei/huawei-nvme.c
>> @@ -41,6 +41,7 @@
>>   #define CREATE_CMD
>>   #include "huawei-nvme.h"
>>   
>> +#define HW_SSD_PCI_VENDOR_ID 0x19E5
>>   #define ARRAY_NAME_LEN 80
>>   #define NS_NAME_LEN    40
>>   
>> @@ -80,16 +81,15 @@ static int huawei_get_nvme_info(int fd, struct huawei_list_item *item, const cha
>>   		return err;
>>   
>>   	/*identify huawei device*/
>> -	if (strstr(item->ctrl.mn, "Huawei") == NULL) {
>> +	if ((strstr(item->ctrl.mn, "Huawei") == NULL) \
>> +		&& (le16_to_cpu(item->ctrl.vid) != HW_SSD_PCI_VENDOR_ID)) {
>>   		
> Consider following coding style to avoid \ in the code and break at the
> &&.
>          if (err)
>                  return err;
> 
> -       /*identify huawei device*/
> -       if ((strstr(item->ctrl.mn, "Huawei") == NULL) \
> -               && (le16_to_cpu(item->ctrl.vid) != HW_SSD_PCI_VENDOR_ID)) {
> +       /* identify huawei device */
> +       if ((strstr(item->ctrl.mn, "Huawei") == NULL) &&
> +           (le16_to_cpu(item->ctrl.vid) != HW_SSD_PCI_VENDOR_ID)) {
>                  item->huawei_device = false;
>                  return 0;
>          }
> 
> item->huawei_device = false;
>>   		return 0;
>>   	}
>> -	else
>> -		item->huawei_device = true;
>>   
>> +	item->huawei_device = true;
>>   	item->nsid = nvme_get_nsid(fd);
>> -	err = nvme_identify_ns(fd, item->nsid,
>> -							0, &item->ns);
>> +	err = nvme_identify_ns(fd, item->nsid, 0, &item->ns);
>>   	if (err)
>>   		return err;
>>   
>>
> 
> 
> 
> .
> 


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
