Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBB50C00144
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Aug 2022 21:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IH7SUfAFawEEqDDR/Aw5tQ7kushbt7XtMM4gT+NXNyE=; b=Kk5Y7yaFeJXVSwhMvVkmw/mZ3w
	x8yHIPKfcmPhmOZ0bcA4VUBOVTOzMoGHvE5dSy+PbNu2QNOo4DhfzgNIoAHKjKEf7/gNoxX7CrQXn
	0FEFykE5ruGe78ZJbNRUGGYRq8FEueNgM9Qm52a3KlSY8pQNbgGvhBfW7txhlrE4A2apKil6PK/V/
	NU5TLF7tmqmTWYHxV4laVlnPTlSX4oB8kDhygj23BLNvm9iExedROgD0cfwkZEuPMfcuJFc/r77yp
	G20zltdRJl4NiQZzeFwtNhdDDf8+tCWrdEvduUJR6NbM4M3eEsgdH1xnpTbTRJtg6XfNvvpEX6D3o
	GjG7WxIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIcZQ-00AbfH-0q; Mon, 01 Aug 2022 21:03:24 +0000
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIcZM-00AbcU-Ui
	for linux-nvme@lists.infradead.org; Mon, 01 Aug 2022 21:03:22 +0000
Received: by mail-pj1-x1035.google.com with SMTP id w17-20020a17090a8a1100b001f326c73df6so11731097pjn.3
        for <linux-nvme@lists.infradead.org>; Mon, 01 Aug 2022 14:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=IH7SUfAFawEEqDDR/Aw5tQ7kushbt7XtMM4gT+NXNyE=;
        b=ZqWLj0OJYNRUPXxVC6tj6GSJir/W9NHOYUWYgPta6uWM5OUo3xUH3OMz/hIVEv8cVT
         qsOuyT+JOIxVIDjV8Fc5pjumpWpknL3Yj1WbsQeGX/VozqV02Si2I5giH0Ej3nAB5x/J
         d6gQon7IAkYeaIXRSiNWRIk9GzvpNQnXNRNvIKp7bYo2aCbVSFqbOQnws0u3QuiFhraI
         77Xg6zPxAf1/3IyIq9Hgwo7LmaBi4Mf6ZB1OkJTi0tVOPUUR8fBYVsJW6xIpr9qK9aII
         Cf1VVSp6+u9RiPxv+GlJ+5HoiscnD1Q7DE73eV+jfPgr1pCYkUelPffs8vYv0F+HAAqq
         PNJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IH7SUfAFawEEqDDR/Aw5tQ7kushbt7XtMM4gT+NXNyE=;
        b=qJt6EUUS8pTRDPokMA0Vavynx/TBBsppBJf/rsFjHK4gDe3OJAyB/omjL+BIuLG9aR
         DXWluu3oQqQCeDvS8zQtfo67HTplHmva88EPnpeJWT3+V3HATOKXeWDo2b/fpr12HU8Z
         LUpDmVYb0uXftlueMzlCte1VV/Heg8QNeGS3tLbVjmEjGOgjk4KjefLa0b1K8tGSRJjj
         6F6krk2KOELdZ6mEamUAzegUQYnRs33fzJL8xwe7/lWP3cWPj99I4bbBToHjgc3+gBOv
         Xg3x3/5XNrXyO0oQI0wsRvDzDuNILLWrelIY5vbccFw8Xy8AitILYTkHdzuV+If0TtRV
         SzyQ==
X-Gm-Message-State: ACgBeo2988NDSV/C3ChCMzN8G6Gs9UStiCduSenqALrG6AJ+7YfCSJIZ
	FiEwom0OcyTvbrjoWQLUXI0=
X-Google-Smtp-Source: AA6agR4sQ6JAK1dNHtj7pqMlrTu5Dgz5BdeMGIpIYvOHQSV2SA/MWb/Eho85tRPq1YESB7Om2t0jig==
X-Received: by 2002:a17:90a:1048:b0:1f3:e9b:2ab4 with SMTP id y8-20020a17090a104800b001f30e9b2ab4mr21479929pjd.106.1659387797396;
        Mon, 01 Aug 2022 14:03:17 -0700 (PDT)
Received: from [10.69.47.244] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id p1-20020a654901000000b0041ab5647a0dsm8044735pgs.41.2022.08.01.14.03.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 14:03:17 -0700 (PDT)
Message-ID: <0b5001ed-050f-f5d0-72ee-3cc2ffc7f9b8@gmail.com>
Date: Mon, 1 Aug 2022 14:03:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH] Revert "nvme-fc: fold t fc_update_appid into
 fc_appid_store"
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, "Ewan D. Milne" <emilne@redhat.com>
Cc: linux-nvme@lists.infradead.org, muneendra.kumar@broadcom.com,
 james.smart@broadcom.com, stable@vger.kernel.org
References: <20220801162713.17324-1-emilne@redhat.com>
 <20220801182714.GA17613@lst.de>
From: James Smart <jsmart2021@gmail.com>
In-Reply-To: <20220801182714.GA17613@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220801_140321_042497_D99834DD 
X-CRM114-Status: GOOD (  18.03  )
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

On 8/1/2022 11:27 AM, Christoph Hellwig wrote:
> On Mon, Aug 01, 2022 at 12:27:13PM -0400, Ewan D. Milne wrote:
>> This reverts commit c814153c83a892dfd42026eaa661ae2c1f298792.
>>
>> The commit c814153c83a8 "nvme-fc: fold t fc_update_appid into fc_appid_store"
>> changed the userspace interface, because the code that decrements "count"
>> to remove a trailing '\n' in the parsing results in the decremented value being
>> incorrectly be returned from the sysfs write.  Fix this by revering the commit.
> 
> Wouldn't something like the patch below be much simpler and cleaner:
> 
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 9987797620b6d..e24ab688f00d5 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -3878,6 +3878,7 @@ static int fc_parse_cgrpid(const char *buf, u64 *id)
>   static ssize_t fc_appid_store(struct device *dev,
>   		struct device_attribute *attr, const char *buf, size_t count)
>   {
> +	size_t orig_count = count;
>   	u64 cgrp_id;
>   	int appid_len = 0;
>   	int cgrpid_len = 0;
> @@ -3902,7 +3903,7 @@ static ssize_t fc_appid_store(struct device *dev,
>   	ret = blkcg_set_fc_appid(app_id, cgrp_id, sizeof(app_id));
>   	if (ret < 0)
>   		return ret;
> -	return count;
> +	return orig_count;
>   }
>   static DEVICE_ATTR(appid_store, 0200, NULL, fc_appid_store);
>   #endif /* CONFIG_BLK_CGROUP_FC_APPID */
> 

Reviewed-by: James Smart <jsmart2021@gmail.com>

looks good on my end.

-- james

