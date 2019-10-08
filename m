Return-Path: <SRS0=/gup=YB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E2DAC10F14
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Oct 2019 12:30:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4955C206BB
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Oct 2019 12:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rWavDfVb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="c5agwUlE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4955C206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zMhjEAwiiggl/LAehyaQWeBrIbCp3ldFIEN4eyklMdk=; b=rWavDfVb3U9aSS
	Gdkrnn+ZZQ4BDVTU1ug3sfb0fdSVgj8z9ldxBZhMtdrXxAICi30BfbZOO/Owy59k8f/L/soG2lowD
	kPwEFCmcqPnbhdRlOzp9F84VfOSJU8T6gIOMcD23qwfMCk3KIJ5t43zgXJNKkFu0jQ00IyF8ovwNc
	PsB0p3py4XVwpmhQmxghqKgPYG+x7uSmrJLtWmuFTO9e1wlqNFhsG3DRE59YJEuIC+ebXZzXiBBER
	Vs/u45ZaD6L6J6s/iVDR92bL9ssFWo+nONvVhUOawr1uyHreDGRfT2PQk4rCDDc0WKI3+utbm/zXe
	TACigWzRjdjV12YOZubg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iHocy-0006IC-Co; Tue, 08 Oct 2019 12:30:08 +0000
Received: from mta-02.yadro.com ([89.207.88.252] helo=mta-01.yadro.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iHocu-0005jh-Fq
 for linux-nvme@lists.infradead.org; Tue, 08 Oct 2019 12:30:06 +0000
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 1602943DDB;
 Tue,  8 Oct 2019 12:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 mime-version:content-transfer-encoding:content-id:content-type
 :content-type:content-language:accept-language:in-reply-to
 :references:message-id:date:date:subject:subject:from:from
 :received:received:received:received; s=mta-01; t=1570537801; x=
 1572352202; bh=G7oHxSCSMAWIh/83KLf+pEAxKUUe1xb5HuFZ/gEenK4=; b=c
 5agwUlENClnWHkvKqqo9jUdHBJlElafHUQ8+0hVSSUecmRZ2c/Qr4LwLPl4YT7tu
 Dk6bEQ0tf107sxjDqAWqhsioaslJNzUB3Yo01sag+K693fc0rB4vsjsI53yeo0iI
 VFM3woAionm7m5tMzfBJmENO7Sr7VQ+zy9B2Xhn900=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zzK7mgra8TTB; Tue,  8 Oct 2019 15:30:01 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id A3F8942002;
 Tue,  8 Oct 2019 15:30:01 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (172.17.10.102) by
 T-EXCH-02.corp.yadro.com (172.17.10.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Tue, 8 Oct 2019 15:30:01 +0300
Received: from T-EXCH-02.corp.yadro.com ([fe80::19dd:9b61:5447:ff23]) by
 T-EXCH-02.corp.yadro.com ([fe80::19dd:9b61:5447:ff23%14]) with mapi id
 15.01.0669.032; Tue, 8 Oct 2019 15:30:01 +0300
From: Mikhail Malygin <m.malygin@yadro.com>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH v4] nvmet: add revalidate ns sysfs attribute to handle
 device resize
Thread-Topic: [PATCH v4] nvmet: add revalidate ns sysfs attribute to handle
 device resize
Thread-Index: AQHVfUltZKcm0YY3TEO+oTvXzLRLQKdQe1YA
Date: Tue, 8 Oct 2019 12:30:01 +0000
Message-ID: <4E13FAFB-C499-4491-940B-DAE0DB54856B@yadro.com>
References: <20190926231940.7494-1-m.malygin@yadro.com>
 <20191007195709.6227-1-m.malygin@yadro.com>
 <DM6PR04MB57544FD6592EAD5A6E4B037B869A0@DM6PR04MB5754.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB57544FD6592EAD5A6E4B037B869A0@DM6PR04MB5754.namprd04.prod.outlook.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [172.17.128.132]
Content-ID: <71BAD622AB8F0F47BADB63737E1B2317@yadro.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191008_053004_928415_71AC6B76 
X-CRM114-Status: GOOD (  17.28  )
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
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thanks, posted an updated version.

> On 8 Oct 2019, at 05:30, Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com> wrote:
> 
> Hi Mikhail,
> 
> Please some inline nit comments.
> 
> On 10/7/19 12:57 PM, m.malygin@yadro.com wrote:
>> From: Mikhail Malygin <m.malygin@yadro.com>
>> nit :-
>> Currently device size is cached in ns->size field on namespace enable, so
>> any device size change after that can't bee seen by initiator.
> nit :- any device size change after that can't bee seen by the
> initiator.
>> This patch adds revalidate namespace attribute. Once it is written,
>> target refreshes ns->size property and calls nvmet_ns_changed
>> so initator may perform namespace rescan
> 
> nit :- so initiator may perform namespace rescan.
> 
>> 
>> Signed-off-by: Mikhail Malygin <m.malygin@yadro.com>
>> ---
>>  drivers/nvme/target/configfs.c    | 16 +++++++++++++++
>>  drivers/nvme/target/core.c        | 27 ++++++++++++++++++++++++
>>  drivers/nvme/target/io-cmd-bdev.c | 10 +++++++--
>>  drivers/nvme/target/io-cmd-file.c | 34 +++++++++++++++++++++----------
>>  drivers/nvme/target/nvmet.h       |  3 +++
>>  5 files changed, 77 insertions(+), 13 deletions(-)
>> 
>> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
>> index 98613a45bd3b..337e967190c5 100644
>> --- a/drivers/nvme/target/configfs.c
>> +++ b/drivers/nvme/target/configfs.c
>> @@ -545,6 +545,21 @@ static ssize_t nvmet_ns_buffered_io_store(struct config_item *item,
>> 
>>  CONFIGFS_ATTR(nvmet_ns_, buffered_io);
>> 
>> +static ssize_t nvmet_ns_revalidate_store(struct config_item *item,
>> +		const char *page, size_t count)
>> +{
>> +	struct nvmet_ns *ns = to_nvmet_ns(item);
>> +	int ret;
>> +
>> +	ret = nvmet_ns_revalidate(ns);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return count;
>> +}
>> +
>> +CONFIGFS_ATTR_WO(nvmet_ns_, revalidate);
>> +
>>  static struct configfs_attribute *nvmet_ns_attrs[] = {
>>  	&nvmet_ns_attr_device_path,
>>  	&nvmet_ns_attr_device_nguid,
>> @@ -552,6 +567,7 @@ static struct configfs_attribute *nvmet_ns_attrs[] = {
>>  	&nvmet_ns_attr_ana_grpid,
>>  	&nvmet_ns_attr_enable,
>>  	&nvmet_ns_attr_buffered_io,
>> +	&nvmet_ns_attr_revalidate,
>>  #ifdef CONFIG_PCI_P2PDMA
>>  	&nvmet_ns_attr_p2pmem,
>>  #endif
>> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
>> index 3a67e244e568..122bcbdb5c05 100644
>> --- a/drivers/nvme/target/core.c
>> +++ b/drivers/nvme/target/core.c
>> @@ -620,6 +620,33 @@ void nvmet_ns_disable(struct nvmet_ns *ns)
>>  	mutex_unlock(&subsys->lock);
>>  }
>> 
>> +int nvmet_ns_revalidate(struct nvmet_ns *ns)
>> +{
>> +	struct nvmet_subsys *subsys = ns->subsys;
>> +	loff_t ns_size = ns->size;
>> +	u32 ns_blksize_shift = ns->blksize_shift;
>> +	int ret = 0;
> nit:- Please consider :-
> 	struct nvmet_subsys *subsys = ns->subsys;
> 	u32 ns_blksize_shift = ns->blksize_shift;
> 	loff_t ns_size = ns->size;
> 	int ret = 0;
>> +
>> +	mutex_lock(&subsys->lock);
>> +	if (!ns->enabled)
>> +		goto out_unlock;
>> +
>> +	if (ns->bdev)
>> +		nvmet_bdev_ns_read_size(ns);
>> +	else if (ns->file)
>> +		ret = nvmet_file_ns_read_size(ns);
>> +
>> +	if (ret)
>> +		goto out_unlock;
> 
> Nit:- since ret gets initialized as a part of the ns->file == true
> why not ?
> 	if (ns->bdev)
> 		nvmet_bdev_ns_read_size(ns);
> 	else if (ns->file) {
> 		ret = nvmet_file_ns_read_size(ns);
> 		if (ret)
> 			goto out_unlock
> 	}
>> +
>> +	if (ns->size != ns_size || ns->blksize_shift != ns_blksize_shift)
>> +		nvmet_ns_changed(subsys, ns->nsid);
>> +
>> +out_unlock:
>> +	mutex_unlock(&subsys->lock);
>> +	return ret;
>> +}
>> +
>>  void nvmet_ns_free(struct nvmet_ns *ns)
>>  {
>>  	nvmet_ns_disable(ns);
>> diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
>> index de0bff70ebb6..ac8229deeccc 100644
>> --- a/drivers/nvme/target/io-cmd-bdev.c
>> +++ b/drivers/nvme/target/io-cmd-bdev.c
>> @@ -47,6 +47,12 @@ void nvmet_bdev_set_limits(struct block_device *bdev, struct nvme_id_ns *id)
>>  	id->nows = to0based(ql->io_opt / ql->logical_block_size);
>>  }
>> 
>> +void nvmet_bdev_ns_read_size(struct nvmet_ns *ns)
>> +{
>> +	ns->size = i_size_read(ns->bdev->bd_inode);
>> +	ns->blksize_shift = blksize_bits(bdev_logical_block_size(ns->bdev));
>> +}
>> +
>>  int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
>>  {
>>  	int ret;
>> @@ -62,8 +68,8 @@ int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
>>  		ns->bdev = NULL;
>>  		return ret;
>>  	}
>> -	ns->size = i_size_read(ns->bdev->bd_inode);
>> -	ns->blksize_shift = blksize_bits(bdev_logical_block_size(ns->bdev));
>> +
>> +	nvmet_bdev_ns_read_size(ns);
>>  	return 0;
>>  }
>> 
>> diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
>> index 05453f5d1448..cff39fea6d85 100644
>> --- a/drivers/nvme/target/io-cmd-file.c
>> +++ b/drivers/nvme/target/io-cmd-file.c
>> @@ -27,10 +27,30 @@ void nvmet_file_ns_disable(struct nvmet_ns *ns)
>>  	}
>>  }
>> 
>> +int nvmet_file_ns_read_size(struct nvmet_ns *ns)
>> +{
>> +	int ret;
>> +	struct kstat stat;
> nit again :-
> 	struct kstat stat;
> 	int ret;
>> +
>> +	ret = vfs_getattr(&ns->file->f_path, &stat, STATX_SIZE,
>> +				AT_STATX_FORCE_SYNC);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ns->size = stat.size;
>> +	/*
>> +	 * i_blkbits can be greater than the universally accepted upper bound,
>> +	 * so make sure we export a sane namespace lba_shift.
>> +	 */
>> +	ns->blksize_shift = min_t(u8,
>> +			file_inode(ns->file)->i_blkbits, 12);
>> +
>> +	return 0;
>> +}
>> +
>>  int nvmet_file_ns_enable(struct nvmet_ns *ns)
>>  {
>>  	int flags = O_RDWR | O_LARGEFILE;
>> -	struct kstat stat;
>>  	int ret;
>> 
>>  	if (!ns->buffered_io)
>> @@ -43,19 +63,11 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
>>  		return PTR_ERR(ns->file);
>>  	}
>> 
>> -	ret = vfs_getattr(&ns->file->f_path,
>> -			&stat, STATX_SIZE, AT_STATX_FORCE_SYNC);
>> +	ret = nvmet_file_ns_read_size(ns);
> nit:- no need for following new line.
>> +
>>  	if (ret)
>>  		goto err;
>> 
>> -	ns->size = stat.size;
>> -	/*
>> -	 * i_blkbits can be greater than the universally accepted upper bound,
>> -	 * so make sure we export a sane namespace lba_shift.
>> -	 */
>> -	ns->blksize_shift = min_t(u8,
>> -			file_inode(ns->file)->i_blkbits, 12);
>> -
>>  	ns->bvec_cache = kmem_cache_create("nvmet-bvec",
>>  			NVMET_MAX_MPOOL_BVEC * sizeof(struct bio_vec),
>>  			0, SLAB_HWCACHE_ALIGN, NULL);
>> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
>> index c51f8dd01dc4..ccdfdcfce65b 100644
>> --- a/drivers/nvme/target/nvmet.h
>> +++ b/drivers/nvme/target/nvmet.h
>> @@ -408,6 +408,7 @@ struct nvmet_ns *nvmet_find_namespace(struct nvmet_ctrl *ctrl, __le32 nsid);
>>  void nvmet_put_namespace(struct nvmet_ns *ns);
>>  int nvmet_ns_enable(struct nvmet_ns *ns);
>>  void nvmet_ns_disable(struct nvmet_ns *ns);
>> +int nvmet_ns_revalidate(struct nvmet_ns *ns);
>>  struct nvmet_ns *nvmet_ns_alloc(struct nvmet_subsys *subsys, u32 nsid);
>>  void nvmet_ns_free(struct nvmet_ns *ns);
>> 
>> @@ -485,6 +486,8 @@ int nvmet_bdev_ns_enable(struct nvmet_ns *ns);
>>  int nvmet_file_ns_enable(struct nvmet_ns *ns);
>>  void nvmet_bdev_ns_disable(struct nvmet_ns *ns);
>>  void nvmet_file_ns_disable(struct nvmet_ns *ns);
>> +void nvmet_bdev_ns_read_size(struct nvmet_ns *ns);
>> +int nvmet_file_ns_read_size(struct nvmet_ns *ns);
>>  u16 nvmet_bdev_flush(struct nvmet_req *req);
>>  u16 nvmet_file_flush(struct nvmet_req *req);
>>  void nvmet_ns_changed(struct nvmet_subsys *subsys, u32 nsid);
>> 
> 


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
