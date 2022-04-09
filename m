Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA0D3C433F5
	for <linux-nvme@archiver.kernel.org>; Sat,  9 Apr 2022 00:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+70jcGwnbmKBOQZOc+MnyuIJCHC+wU02lx9VuDTKjTQ=; b=tcHY4QHaJwqmERDfbmcIDtTXOB
	BM9Drt5F0euyXZSOQqvKtuwzwTs1qZC05aluuDdevTgDxZ6SkHCZpp5PJxXyS8XgGH2544wOTFXJq
	hRK751Wnk1GPekwA/suLT2AFlEeb4ttlczifgdj9qfV8C/JwFO/6a1SFoGhI9dCoZGdVpGeUFOqWN
	I1rMcEnjgjXJ4trgK0yKLGltfNggvmnsTfvIo65CUzV8fBjSbAcT/iyMTcZDXyYCysHTEPWOLnOtv
	ecaaZva331CqrSF9oKF094sxoKpRwf7PPCYFcrFktSockSAiqF8e2d3wCTiUyNus+X93UUuCF7bfE
	xblK7mLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nczQx-001c1H-SN; Sat, 09 Apr 2022 00:58:35 +0000
Received: from mail-m118204.qiye.163.com ([115.236.118.204])
 by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nczQt-001c0w-W4
 for linux-nvme@lists.infradead.org; Sat, 09 Apr 2022 00:58:33 +0000
Received: from [192.168.1.164] (unknown [218.106.117.245])
 by mail-m118204.qiye.163.com (HMail) with ESMTPA id B466FA217D7;
 Sat,  9 Apr 2022 08:58:28 +0800 (CST)
Message-ID: <21ac620f-d234-13a1-0de7-e3ec1b3272db@kingtous.cn>
Date: Sat, 9 Apr 2022 08:58:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
From: Tao Jin <me@kingtous.cn>
Subject: Re: [PATCH] fix: nvme_update_ns_info method should be called even if
 nvme_ms_ids_equal return false
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, axboe@fb.com, sagi@grimberg.me,
 kingtous <kingtous@qq.com>
References: <20220408051915.GA31955@lst.de>
 <ABwAxgCYBwe5Iq2fM1-8qqrc.3.1649398333597.Hmail.me@kingtous.cn>
 <20220408062210.GA410@lst.de>
 <7b59552e-196e-d06a-f057-aaa3e9432841@kingtous.cn>
 <20220408080721.GA2888@lst.de>
 <YlBSO/vH7DjE6kC9@kbusch-mbp.dhcp.thefacebook.com>
 <20220408160424.GB27746@lst.de>
Content-Language: en-US
In-Reply-To: <20220408160424.GB27746@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
 kWDxoPAgseWUFZKDYvK1lXWShZQU83V1ktWUFJV1kPCRoVCBIfWUFZQkJMS1ZLT01PTB9JHUhIT0
 9VAhYTFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OSo6HCo6MTkCAk4WNjgfLBQ4
 GjBPFAFVSlVKTU9CT01OQktCSkhIVTMWGhIXVRYeOxASFRwPFA4IVRgVRVlXWRILWUFZSUpDVUpL
 TVVKSkxVSU9OWVdZCAFZQU9CQkk3Bg++
X-HM-Tid: 0a800bd45e862d26kusnb466fa217d7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220408_175832_204991_62332539 
X-CRM114-Status: GOOD (  19.90  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thanks for your kind reply.

The output from command "nvme ns-descs /dev/nvme0n1" shows below:

before suspend:
NVME Namespace Identification Descriptors NS 1:
uuid    : 01000000-0000-0000-0000-000000000000

but after suspend, uuid seems disapeared:
NVME Namespace Identification Descriptors NS 1:
eui64   : 0100000000000000

If I do more suspend operations, the output is the same:
NVME Namespace Identification Descriptors NS 1:
eui64   : 0100000000000000


Note that I'm using the kernel which customed by myself, which comments 
out "goto out_free_id". It means "nvme_update_ns_info" will be called 
even if invalidate ids failed. Because I can't do suspend operation if 
using official kernel, which will cause my SSD directly invisible in 
Linux and trigger ext4 error, freezing the laptop.

```
static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_ids *ids)
{
	struct nvme_id_ns *id;
	int ret = NVME_SC_INVALID_NS | NVME_SC_DNR;

	if (test_bit(NVME_NS_DEAD, &ns->flags))
		goto out;

	ret = nvme_identify_ns(ns->ctrl, ns->head->ns_id, ids, &id);
	if (ret)
		goto out;

	ret = NVME_SC_INVALID_NS | NVME_SC_DNR;
	if (!nvme_ns_ids_equal(&ns->head->ids, ids)) {
		dev_err(ns->ctrl->device,
			"identifiers changed for nsid %d\n", ns->head->ns_id);
-		goto out_free_id;
	}

	ret = nvme_update_ns_info(ns, id);

out_free_id:
	kfree(id);
out:
	/*
	 * Only remove the namespace if we got a fatal error back from the
	 * device, otherwise ignore the error and just move on.
	 *
	 * TODO: we should probably schedule a delayed retry here.
	 */
	if (ret > 0 && (ret & NVME_SC_DNR))
		nvme_ns_remove(ns);
}
```
In addition, Windows 10/11 has no suspend issue in this laptop. It's 
really weird.

在 2022/4/9 00:04, Christoph Hellwig 写道:
> On Fri, Apr 08, 2022 at 09:18:19AM -0600, Keith Busch wrote:
>> On Fri, Apr 08, 2022 at 10:07:21AM +0200, Christoph Hellwig wrote:
>>> On Fri, Apr 08, 2022 at 03:56:49PM +0800, 金韬 wrote:
>>>> This is output from dmesg. Seems that "eui" has changed.
>>>>
>>>> [    2.086226] loop0: detected capacity change from 0 to 8
>>>> [   26.577001] eui changed from 0100000000000000 to 0000000000000001
>>>> [   26.577003] nvme nvme0: identifiers changed for nsid 1
>>>
>>> Ok, looks like the device is broken and changes the EUID after power
>>> cycles.  Can you send the output of lspci -v?
>>>
>>> Also just out of curiousity, does the ID keep changing if you do more
>>> suspend cycles?
>>
>> The eui isn't legit in the first place (no OUI), and appears to be swqpping the
> 
> Yes.
> 
>> byte order during resume. This should be reported to the vendor.
> 
> Well, the id-ns output posted earlier shows the same output before and
> after resume.  Which is really weird.
> 
> Either way we'll have to quirk it some way.
> 
> Just to pointpoint this down a bit, what does
> 
>     nvme ns-descs /dev/nvme0n1
> 
> report?  I wonder if we get different IDs from the different methods
> to retrive them given that namespace allocation looks at the
> Namespace Identification Descriptor last, while revalidation only
> looks at Identify Namespace.
> 

