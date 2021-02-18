Return-Path: <SRS0=yJEp=HU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4FBFC433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Feb 2021 09:52:14 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FDEE64E68
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Feb 2021 09:52:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FDEE64E68
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=sQCR8Wdg3SIP6oxGUV1xJ4zaHI0LkB9trMUOlq3rwMg=; b=ed6sIcSxpL1avAST/19GGOLWy
	rVwR5JLi4OI6H36Y5114w2fiGKVtWk9XIKSu5sfQgeMFpdNU3djlN2X3kY2YdZciQ/zw97hCA77Hf
	euV4rErnaD2O4CI+sIMmzJkpmKs9+QOULAQS4Qn2aqGadkadEb3L+NpViSjJ88GBs0fGgVGmwvhVO
	fVdxODp0NDWf5yXEiOqEXSYQ5ScdiYoKwvNDi86mspGRRDB7qzO/eXBUu47XrhvMqa2SwgXEM/f7C
	y0wZ66pqQnoTTNGONvGE2P2a3odto10k3jjzNu5wmRwPI7f2V6LPEW5GOqRej+sirKUUhTzf+nc/Z
	DKRB6U8JA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lCfyM-0007uL-80; Thu, 18 Feb 2021 09:51:46 +0000
Received: from hqnvemgate26.nvidia.com ([216.228.121.65])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lCfyJ-0007t8-36
 for linux-nvme@lists.infradead.org; Thu, 18 Feb 2021 09:51:44 +0000
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B602e38ad0000>; Thu, 18 Feb 2021 01:51:41 -0800
Received: from [172.27.0.36] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 18 Feb
 2021 09:51:38 +0000
Subject: Re: [PATCH 1/1] nvmet: allow setting model_number once
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "kbusch@kernel.org"
 <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>
References: <20210217181153.15343-1-mgurtovoy@nvidia.com>
 <BYAPR04MB4965D3231E5681CD2642EDF686859@BYAPR04MB4965.namprd04.prod.outlook.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <cbdcaf4c-1aa4-8949-ebbf-83f54c2a274b@nvidia.com>
Date: Thu, 18 Feb 2021 11:51:36 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB4965D3231E5681CD2642EDF686859@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1613641901; bh=ryh3UcVsutDlfLXkWfywBammasvG8NtBfbCedkZc/sI=;
 h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
 MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 Content-Language:X-Originating-IP:X-ClientProxiedBy;
 b=EBmv+IZvS6goX4JNRaW78ij0J3ecU5jGwUZswHGlxfEyh+9ZxgW4efaIA7hRxXBi8
 DbofxpajCTcrZR/xBg5uJpsQ3dYQLmy0Tto3qY1HMDKuSoNTfzsrgpye25JT1uvFZj
 sOreyhGfKilIpl3Ie9h4+ohdK+m9dZTtnTnw7iTDYsrL5mR0CEcGLhZ3H9ziBnoDRw
 Kcwp/emqiiX9rUTsXdc0cGPD+akHJdNhKHJhi/MtwvKSjobSFTzyjVagFq52oHlr7Q
 vwT2jIXizJztTOX09iUSTWUkwJGBBJK7A9yESQXlb0fdfafPdawBQxT2zmtayYYgKJ
 S1P1L0dS+aQYQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210218_045143_241378_4BEC3317 
X-CRM114-Status: GOOD (  19.48  )
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
Cc: "oren@nvidia.com" <oren@nvidia.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 2/18/2021 5:17 AM, Chaitanya Kulkarni wrote:
> Max,
>
> On 2/17/21 10:12, Max Gurtovoy wrote:
>> In case we have already established connection to nvmf target, it
>> shouldn't be allowed to change the model_number. E.g. if someone will
>> identify ctrl and get model_number of "my_model" later on will change
>> the model_numbel via configfs to "my_new_model" this will break the NVM
>> specification for "Get Log Page =96 Persistent Event Log" that refers to
>> Model Number as: "This field contains the same value as reported in the
>> Model Number field of the Identify Controller data structure, bytes
>> 63:24."
> We don't support persistent event log page since there is no use
> case for target to have human readable format with timestamps,
> instead we do maintain the error log page which has information
> about the errors if user wants.
>
> I'll let Christoph/Sagi decide if we really need to implement
> Persistent Event (PE) log and so does this behavior.
>
> Regarding preventing from changing the model_number when subsys is
> connected to the host, that needs a fix and I sent a patch for that.
>
> We can ignore that patch if we decide to go with this patch with
> PR log page.

what is wrong with this patch ?

why you need the rcu logic in the driver and why do you want to preserve =

a case that initiator A connect to subsystem "my_sub" and see MN =3D=3D =

Linux and after disconnect and re-connect it might see MN =3D New_Linux ?


>
>> Although it doesn't mentioned explicitly that this field can't be
>> changed, we can assume it.
>>
>> So allow setting this field only once: using configfs or in the first
>> identify ctrl operation.
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
