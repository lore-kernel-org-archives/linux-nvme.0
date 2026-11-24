Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C28B606A31E
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Nov 2026 11:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=IeVQq47m;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=XNCIgII4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=wphDWJGeLEzTABCjRyoVUhFDggPfKzEC1PpOIJrD5aI=; b=IeVQq47mhGpE9e
	f4gjRGqSMdLpJYaw/T9wbUqpRodOWJ8jcMuwhHiZc4ez7oDqDxeLZbdjw0nokaZv9YzKML0hpt8nE
	v8iz05UVzhsGN26f92f1w4ES9QjNVdCEXXBkijhEGIKXpqHkge4lwQlO4aRoZ53HONf1iuF1UsF5J
	to6q442B16IyXH5pDYh+gbWCZySAPVTC5Nid6psgXzg4fw6QvRkgpeKhFbbJ7feIs1VqIRASooSxl
	ie5tecDlyRvtb3JUZ4DGxDd3dUS0MW6W1oh6qUYYtNy6lpP9gmgXPwW/beh8TPhYNK9vXD19VYW3a
	HH8XlaTDKSORyr9UXzaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVoco-00000006Ld4-31g2;
	Tue, 24 Nov 2026 11:23:50 +0000
Received: from out30-98.freemail.mail.aliyun.com ([115.124.30.98])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVocV-00000006LbL-3ETx
	for linux-nvme@lists.infradead.org;
	Tue, 24 Nov 2026 11:23:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795519403; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=wphDWJGeLEzTABCjRyoVUhFDggPfKzEC1PpOIJrD5aI=;
	b=XNCIgII4jIcJrF++gJe3v2pgziF7mAdVbfHgEUZBxT/NjOgHEv45fpXvTE/YhmKMXDOs5JcugG26ecXL/hI/3/HshmHySBArCf0hJu9nT6nhJsbHl6tZB59r0r+OVf+CoKMjaRFWYCXuWa7Pydzu2jpUCipgN+OvPCZAyC5ZD3o=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XFOV3xH_1795519401;
Received: from 30.178.69.52(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XFOV3xH_1795519401 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 24 Nov 2026 19:23:22 +0800
Message-ID: <dca7ae80-e1a7-40e3-9d9e-4e86079b1f89@linux.alibaba.com>
Date: Tue, 24 Nov 2026 19:23:20 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] nvme-hwmon: notify hwmon alarms on the SMART /
 Health Status AEN
To: Nilay Shroff <nilay@linux.ibm.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
 Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
References: <20261123112342.2761131-1-kanie@linux.alibaba.com>
 <20261123112342.2761131-2-kanie@linux.alibaba.com>
 <47f4ec19-9e86-45f4-947a-6e00d0bf9c06@linux.ibm.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <47f4ec19-9e86-45f4-947a-6e00d0bf9c06@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261124_032333_716138_A3B0CF98 
X-CRM114-Status: GOOD (  16.91  )
X-Spam-Score: -17.6 (-----------------)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



在 2026/11/24 16:08, Nilay Shroff 写道:
> On 11/23/26 4:53 PM, Guixin Liu wrote:
>> +static void nvme_hwmon_smart_notify(struct work_struct *work)
>> +{
>> +    struct nvme_ctrl *ctrl =
>> +        container_of(work, struct nvme_ctrl, smart_work);
>> +    struct nvme_hwmon_data *data;
>> +    struct device *hwmon;
>> +    bool warn = false;
>> +
>> +    if (nvme_ctrl_state(ctrl) != NVME_CTRL_LIVE)
>> +        return;
>> +
>> +    hwmon = ctrl->hwmon_device;
>> +    if (!hwmon)
>> +        return;
>> +    data = dev_get_drvdata(hwmon);
>> +
>> +    mutex_lock(&data->read_lock);
>> +    if (!nvme_hwmon_get_smart_log(data))
>> +        warn = data->log->critical_warning & NVME_SMART_CRIT_TEMPERATURE;
>> +    mutex_unlock(&data->read_lock);
>> +
>> +    if (warn)
>> +        hwmon_notify_event(hwmon, hwmon_temp, hwmon_temp_alarm, 0);
>> +}
>> +
> We only generate the notification if the NVME_SMART_CRIT_TEMPERATURE bit is set
> in the SMART/Health log page. However, consider the following scenario:
> the host receives a SMART/Health asynchronous event and schedules smart_work, but
> by the time the work executes and reads the SMART/Health log page, the temperature
> has already returned to the normal range.
>
> In that case, the returned log page may no longer have the
> NVME_SMART_CRIT_TEMPERATURE bit set, causing us to skip the notification
> even though a temperature-threshold event was reported.
>
> Perhaps we should also examine aer_subtype and, when it indicates a temperature-
> threshold event, generate the hwmon notification regardless of whether the
> corresponding temperature bit is currently set in the SMART/Health log page.
That makes sense, Change this in v4, thanks. 

Best Regards,
Guixin Liu
>
> Other than this, the rest of the changes look good to me.
>
> Thanks,
> --Nilay


