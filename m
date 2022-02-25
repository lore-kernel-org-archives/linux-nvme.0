Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70ACFC433FE
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Feb 2022 16:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ENCR/zFv2eoqJ+K4x1YPD7qmICPEUEPbzQVGhF4b5Uw=; b=PSKX6++F2rSjGcpt+hWvyf+QzL
	cyp+0I5ckbHIJ10Ngy3cFcAqaEQbGU9Z4csvMDy4d42iJ0XpxVoBLAXjJ9Ulwo8gt4wgHscMKZy/G
	BGKAt0AYxWDnf9r9T76K7kiDTz2FlczE0a3XARI4HpGe+MFVwdBSaak4w0fvn2GYJMHQ/C+cu3yz1
	7TLai6B+eRi8RtlX4BTBgUs2KEy3s7iMAMalhJuAjgNGl6Tx/zRUx6z2+5LnXA4qBK/MPABJrf1Ju
	+Ne1zEtxn+MnEclq1wd40TGI3Ka6Ci3F0F3ZoyWyVWRshF7PyxNLhx+Lk4+uvmISafeBFRFpVPT1T
	uSPRl65w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nNdEs-005r05-5P; Fri, 25 Feb 2022 16:14:38 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nNdEo-005qy6-OR
 for linux-nvme@lists.infradead.org; Fri, 25 Feb 2022 16:14:36 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 56E4D68AA6; Fri, 25 Feb 2022 17:14:31 +0100 (CET)
Date: Fri, 25 Feb 2022 17:14:30 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-crypto@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
 martin.petersen@oracle.com, colyli@suse.de, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCHv3 08/10] block: add pi for nvme enhanced integrity
Message-ID: <20220225161430.GB13845@lst.de>
References: <20220222163144.1782447-1-kbusch@kernel.org>
 <20220222163144.1782447-9-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222163144.1782447-9-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220225_081435_118264_FC84A95B 
X-CRM114-Status: GOOD (  21.03  )
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

On Tue, Feb 22, 2022 at 08:31:42AM -0800, Keith Busch wrote:
> +static __be64 nvme_pi_crc64(void *data, unsigned int len)
> +{
> +	return cpu_to_be64(crc64_rocksoft(data, len));
> +}
> +
> +static blk_status_t nvme_crc64_generate(struct blk_integrity_iter *iter,
> +					enum t10_dif_type type)

Shouldn't the naming be something more like ext_pi_*?  For one thing
I kinda hate having the nvme prefix here in block layer code, but also
nvme supports the normal 8 byte PI tuples, so this is a bit confusing.

> +{
> +	unsigned int i;
> +
> +	for (i = 0 ; i < iter->data_size ; i += iter->interval) {
> +		struct nvme_crc64_pi_tuple *pi = iter->prot_buf;
> +
> +		pi->guard_tag = nvme_pi_crc64(iter->data_buf, iter->interval);
> +		pi->app_tag = 0;
> +
> +		if (type == T10_PI_TYPE1_PROTECTION)
> +			put_unaligned_be48(iter->seed, pi->ref_tag);
> +		else
> +			put_unaligned_be48(0ULL, pi->ref_tag);
> +
> +		iter->data_buf += iter->interval;
> +		iter->prot_buf += iter->tuple_size;
> +		iter->seed++;
> +	}
> +
> +	return BLK_STS_OK;
> +}
> +
> +static bool nvme_crc64_ref_escape(u8 *ref_tag)
> +{
> +	static u8 ref_escape[6] = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
> +
> +	return memcmp(ref_tag, ref_escape, sizeof(ref_escape)) == 0;
> +}
> +
> +static blk_status_t nvme_crc64_verify(struct blk_integrity_iter *iter,
> +				      enum t10_dif_type type)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < iter->data_size; i += iter->interval) {
> +		struct nvme_crc64_pi_tuple *pi = iter->prot_buf;
> +		u64 ref, seed;
> +		__be64 csum;
> +
> +		if (type == T10_PI_TYPE1_PROTECTION) {
> +			if (pi->app_tag == T10_PI_APP_ESCAPE)
> +				goto next;
> +
> +			ref = get_unaligned_be48(pi->ref_tag);
> +			seed = lower_48_bits(iter->seed);
> +			if (ref != seed) {
> +				pr_err("%s: ref tag error at location %llu (rcvd %llu)\n",
> +					iter->disk_name, seed, ref);
> +				return BLK_STS_PROTECTION;
> +			}
> +		} else if (type == T10_PI_TYPE3_PROTECTION) {
> +			if (pi->app_tag == T10_PI_APP_ESCAPE &&
> +			    nvme_crc64_ref_escape(pi->ref_tag))
> +				goto next;
> +		}
> +
> +		csum = nvme_pi_crc64(iter->data_buf, iter->interval);
> +		if (pi->guard_tag != csum) {
> +			pr_err("%s: guard tag error at sector %llu " \
> +			       "(rcvd %016llx, want %016llx)\n",
> +				iter->disk_name, (unsigned long long)iter->seed,
> +				be64_to_cpu(pi->guard_tag), be64_to_cpu(csum));
> +			return BLK_STS_PROTECTION;
> +		}
> +
> +next:
> +		iter->data_buf += iter->interval;
> +		iter->prot_buf += iter->tuple_size;
> +		iter->seed++;
> +	}
> +
> +	return BLK_STS_OK;
> +}
> +
> +static blk_status_t nvme_pi_type1_verify_crc(struct blk_integrity_iter *iter)
> +{
> +	return nvme_crc64_verify(iter, T10_PI_TYPE1_PROTECTION);
> +}
> +
> +static blk_status_t nvme_pi_type1_generate_crc(struct blk_integrity_iter *iter)
> +{
> +	return nvme_crc64_generate(iter, T10_PI_TYPE1_PROTECTION);
> +}
> +
> +static void nvme_pi_type1_prepare(struct request *rq)
> +{
> +	const int tuple_sz = rq->q->integrity.tuple_size;
> +	u64 ref_tag = nvme_pi_extended_ref_tag(rq);
> +	struct bio *bio;
> +
> +	__rq_for_each_bio(bio, rq) {
> +		struct bio_integrity_payload *bip = bio_integrity(bio);
> +		u64 virt = lower_48_bits(bip_get_seed(bip));
> +		struct bio_vec iv;
> +		struct bvec_iter iter;
> +
> +		/* Already remapped? */
> +		if (bip->bip_flags & BIP_MAPPED_INTEGRITY)
> +			break;
> +
> +		bip_for_each_vec(iv, bip, iter) {
> +			unsigned int j;
> +			void *p;
> +
> +			p = bvec_kmap_local(&iv);
> +			for (j = 0; j < iv.bv_len; j += tuple_sz) {
> +				struct nvme_crc64_pi_tuple *pi = p;
> +				u64 ref = get_unaligned_be48(pi->ref_tag);
> +
> +				if (ref == virt)
> +					put_unaligned_be48(ref_tag, pi->ref_tag);
> +				virt++;
> +				ref_tag++;
> +				p += tuple_sz;
> +			}
> +			kunmap_local(p);
> +		}
> +
> +		bip->bip_flags |= BIP_MAPPED_INTEGRITY;
> +	}
> +}
> +
> +static void nvme_pi_type1_complete(struct request *rq, unsigned int nr_bytes)
> +{
> +	unsigned intervals = nr_bytes >> rq->q->integrity.interval_exp;
> +	const int tuple_sz = rq->q->integrity.tuple_size;
> +	u64 ref_tag = nvme_pi_extended_ref_tag(rq);
> +	struct bio *bio;
> +
> +	__rq_for_each_bio(bio, rq) {
> +		struct bio_integrity_payload *bip = bio_integrity(bio);
> +		u64 virt = lower_48_bits(bip_get_seed(bip));
> +		struct bio_vec iv;
> +		struct bvec_iter iter;
> +
> +		bip_for_each_vec(iv, bip, iter) {
> +			unsigned int j;
> +			void *p;
> +
> +			p = bvec_kmap_local(&iv);
> +			for (j = 0; j < iv.bv_len && intervals; j += tuple_sz) {
> +				struct nvme_crc64_pi_tuple *pi = p;
> +				u64 ref = get_unaligned_be48(pi->ref_tag);
> +
> +				if (ref == ref_tag)
> +					put_unaligned_be48(virt, pi->ref_tag);
> +				virt++;
> +				ref_tag++;
> +				intervals--;
> +				p += tuple_sz;
> +			}
> +			kunmap_local(p);
> +		}
> +	}
> +}
> +
> +static blk_status_t nvme_pi_type3_verify_crc(struct blk_integrity_iter *iter)
> +{
> +	return nvme_crc64_verify(iter, T10_PI_TYPE3_PROTECTION);
> +}
> +
> +static blk_status_t nvme_pi_type3_generate_crc(struct blk_integrity_iter *iter)
> +{
> +	return nvme_crc64_generate(iter, T10_PI_TYPE3_PROTECTION);
> +}
> +
> +const struct blk_integrity_profile nvme_pi_type1_crc64 = {
> +	.name			= "NVME-DIF-TYPE1-CRC64",
> +	.generate_fn		= nvme_pi_type1_generate_crc,
> +	.verify_fn		= nvme_pi_type1_verify_crc,
> +	.prepare_fn		= nvme_pi_type1_prepare,
> +	.complete_fn		= nvme_pi_type1_complete,
> +};
> +EXPORT_SYMBOL(nvme_pi_type1_crc64);

All this should probably be EXPORT_SYMBOL_GPL (and I have a series
pending that would remove the exports of the profiles entirely,
but that will need some major rework after your series goes in).

The actual code looks fine to me.

