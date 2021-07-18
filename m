Return-Path: <SRS0=sDNq=MK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC9FC636CA
	for <linux-nvme@archiver.kernel.org>; Sun, 18 Jul 2021 12:58:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE31D600D3
	for <linux-nvme@archiver.kernel.org>; Sun, 18 Jul 2021 12:58:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE31D600D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chronox.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9x6YC7IwOh7LP/AnXDSiIsWCo+P/pAF/7HtCTFAg+ZE=; b=iLto5AjSm2deVD
	GY+3nMAFjGkijuAT3vUGB6A4nTvPMEVX5NcOjE5Vke+kgfzyr04QV5yqslNFJaAexhW1ZOZCvMGPL
	8Z1StHwSvKftbgsnZMNWtCrYTcIWIcrFddyeM8FvlghrX8e2oIUgdb83iy2KILB8SyulfoUGYhqc0
	3iIsxf40zDfJPiQSZB1ef7crM84ndf03MD1F+/q5gHvsNsOOFWJpNySlVLNpP1y8jpjxIzW0Lv0f7
	nQeH5L8RHxb2aGP//nq4KwJBa/0DTEK8Vqi1Sf0ul6FWJRGf0PYrQtgPCLlvor/GWebg9J4Wjgaqq
	X/jKgEq6yGmD68Vu9qJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m56N1-007jJA-EE; Sun, 18 Jul 2021 12:58:11 +0000
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.84])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m56Mw-007jIf-Vs
 for linux-nvme@lists.infradead.org; Sun, 18 Jul 2021 12:58:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1626613078;
 s=strato-dkim-0002; d=chronox.de;
 h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
 From:Subject:Sender;
 bh=KH4PNXBuXKPKwv/8BO2vLueZx4u8AeTvj9rP+8jFQSw=;
 b=AKUlZngGZihPEEvpIwU2LgM9n7BiP3RBjocSR9u3INtnH/13pv+83WGU8xWHfvIVSG
 8YnTmmbUsVHUfT/vFOoK4yKlM8v94d46SntiiHI5CrhGozt4GY0TqPsYHDyNvs4yg/3P
 cWfpj23MYZtZWTT09T0qgH9RUKGgWexmX/pfPMs/tq0VSQ/hB2hbWZcJryxyhiFS1IEv
 lOI7lrdQ+V3LueMtVW2U/+CBj7riK/32/BnHWcimpReW8EUmoglhrjpbt9WNf+9ZgoNK
 7JfwMu9mi6wX8MsOQx2KpoqFuT/fPHwcGnEoYJhS+5tWpGB9TWmpVakowJ3XXmc3caWK
 rcrg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXPbLvSWMgk="
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de by smtp.strato.de (RZmta 47.28.1 DYNA|AUTH)
 with ESMTPSA id 9043bbx6ICvwETC
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Sun, 18 Jul 2021 14:57:58 +0200 (CEST)
From: Stephan =?ISO-8859-1?Q?M=FCller?= <smueller@chronox.de>
To: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org
Subject: Re: [PATCH 07/11] nvme-auth: augmented challenge support
Date: Sun, 18 Jul 2021 14:57:58 +0200
Message-ID: <135556795.PM5aWcGsrQ@positron.chronox.de>
In-Reply-To: <f50f019c-2cf9-c91c-1ef7-e20df8eb0204@suse.de>
References: <20210716110428.9727-1-hare@suse.de>
 <2165597.y8bdKqVMXX@positron.chronox.de>
 <f50f019c-2cf9-c91c-1ef7-e20df8eb0204@suse.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210718_055807_380186_7E49179C 
X-CRM114-Status: GOOD (  20.63  )
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Am Sonntag, 18. Juli 2021, 14:27:48 CEST schrieb Hannes Reinecke:

Hi Hannes,

> On 7/17/21 6:49 PM, Stephan M=FCller wrote:
> > Am Freitag, 16. Juli 2021, 13:04:24 CEST schrieb Hannes Reinecke:
> > =

> > Hi Hannes,
> > =

> >> Implement support for augmented challenge using FFDHE groups.
> >> =

> >> Signed-off-by: Hannes Reinecke <hare@suse.de>
> >> ---
> >> =

> >>   drivers/nvme/host/auth.c | 403 +++++++++++++++++++++++++++++++++++--=
--
> >>   1 file changed, 371 insertions(+), 32 deletions(-)
> >> =

> >> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
> >> index 448a3adebea6..754343aced19 100644
> >> --- a/drivers/nvme/host/auth.c
> >> +++ b/drivers/nvme/host/auth.c
> >> @@ -8,6 +8,8 @@
> >> =

> >>   #include <asm/unaligned.h>
> >>   #include <crypto/hash.h>
> >>   #include <crypto/kpp.h>
> >> =

> >> +#include <crypto/dh.h>
> >> +#include <crypto/ffdhe.h>
> >> =

> >>   #include "nvme.h"
> >>   #include "fabrics.h"
> >>   #include "auth.h"
> >> =

> >> @@ -16,6 +18,8 @@ static u32 nvme_dhchap_seqnum;
> >> =

> >>   struct nvme_dhchap_context {
> >>   =

> >>   	struct crypto_shash *shash_tfm;
> >> =

> >> +	struct crypto_shash *digest_tfm;
> >> +	struct crypto_kpp *dh_tfm;
> >> =

> >>   	unsigned char *key;
> >>   	size_t key_len;
> >>   	int qid;
> >> =

> >> @@ -25,6 +29,8 @@ struct nvme_dhchap_context {
> >> =

> >>   	u8 status;
> >>   	u8 hash_id;
> >>   	u8 hash_len;
> >> =

> >> +	u8 dhgroup_id;
> >> +	u16 dhgroup_size;
> >> =

> >>   	u8 c1[64];
> >>   	u8 c2[64];
> >>   	u8 response[64];
> >> =

> >> @@ -36,6 +42,94 @@ struct nvme_dhchap_context {
> >> =

> >>   	int sess_key_len;
> >>   =

> >>   };
> >> =

> >> +struct nvme_auth_dhgroup_map {
> >> +	int id;
> >> +	const char name[16];
> >> +	const char kpp[16];
> >> +	int privkey_size;
> >> +	int pubkey_size;
> >> +} dhgroup_map[] =3D {
> >> +	{ .id =3D NVME_AUTH_DHCHAP_DHGROUP_NULL,
> >> +	  .name =3D "NULL", .kpp =3D "NULL",
> >> +	  .privkey_size =3D 0, .pubkey_size =3D 0 },
> >> +	{ .id =3D NVME_AUTH_DHCHAP_DHGROUP_2048,
> >> +	  .name =3D "ffdhe2048", .kpp =3D "dh",
> >> +	  .privkey_size =3D 256, .pubkey_size =3D 256 },
> >> +	{ .id =3D NVME_AUTH_DHCHAP_DHGROUP_3072,
> >> +	  .name =3D "ffdhe3072", .kpp =3D "dh",
> >> +	  .privkey_size =3D 384, .pubkey_size =3D 384 },
> >> +	{ .id =3D NVME_AUTH_DHCHAP_DHGROUP_4096,
> >> +	  .name =3D "ffdhe4096", .kpp =3D "dh",
> >> +	  .privkey_size =3D 512, .pubkey_size =3D 512 },
> >> +	{ .id =3D NVME_AUTH_DHCHAP_DHGROUP_6144,
> >> +	  .name =3D "ffdhe6144", .kpp =3D "dh",
> >> +	  .privkey_size =3D 768, .pubkey_size =3D 768 },
> >> +	{ .id =3D NVME_AUTH_DHCHAP_DHGROUP_8192,
> >> +	  .name =3D "ffdhe8192", .kpp =3D "dh",
> >> +	  .privkey_size =3D 1024, .pubkey_size =3D 1024 },
> >> +};
> >> +
> >> +const char *nvme_auth_dhgroup_name(int dhgroup_id)
> >> +{
> >> +	int i;
> >> +
> >> +	for (i =3D 0; i < ARRAY_SIZE(dhgroup_map); i++) {
> >> +		if (dhgroup_map[i].id =3D=3D dhgroup_id)
> >> +			return dhgroup_map[i].name;
> >> +	}
> >> +	return NULL;
> >> +}
> >> +EXPORT_SYMBOL_GPL(nvme_auth_dhgroup_name);
> >> +
> >> +int nvme_auth_dhgroup_pubkey_size(int dhgroup_id)
> >> +{
> >> +	int i;
> >> +
> >> +	for (i =3D 0; i < ARRAY_SIZE(dhgroup_map); i++) {
> >> +		if (dhgroup_map[i].id =3D=3D dhgroup_id)
> >> +			return dhgroup_map[i].pubkey_size;
> >> +	}
> >> +	return -1;
> >> +}
> >> +EXPORT_SYMBOL_GPL(nvme_auth_dhgroup_pubkey_size);
> >> +
> >> +int nvme_auth_dhgroup_privkey_size(int dhgroup_id)
> >> +{
> >> +	int i;
> >> +
> >> +	for (i =3D 0; i < ARRAY_SIZE(dhgroup_map); i++) {
> >> +		if (dhgroup_map[i].id =3D=3D dhgroup_id)
> >> +			return dhgroup_map[i].privkey_size;
> >> +	}
> >> +	return -1;
> >> +}
> >> +EXPORT_SYMBOL_GPL(nvme_auth_dhgroup_privkey_size);
> >> +
> >> +const char *nvme_auth_dhgroup_kpp(int dhgroup_id)
> >> +{
> >> +	int i;
> >> +
> >> +	for (i =3D 0; i < ARRAY_SIZE(dhgroup_map); i++) {
> >> +		if (dhgroup_map[i].id =3D=3D dhgroup_id)
> >> +			return dhgroup_map[i].kpp;
> >> +	}
> >> +	return NULL;
> >> +}
> >> +EXPORT_SYMBOL_GPL(nvme_auth_dhgroup_kpp);
> >> +
> >> +int nvme_auth_dhgroup_id(const char *dhgroup_name)
> >> +{
> >> +	int i;
> >> +
> >> +	for (i =3D 0; i < ARRAY_SIZE(dhgroup_map); i++) {
> >> +		if (!strncmp(dhgroup_map[i].name, dhgroup_name,
> >> +			     strlen(dhgroup_map[i].name)))
> >> +			return dhgroup_map[i].id;
> >> +	}
> >> +	return -1;
> >> +}
> >> +EXPORT_SYMBOL_GPL(nvme_auth_dhgroup_id);
> >> +
> >> =

> >>   struct nvmet_dhchap_hash_map {
> >>   =

> >>   	int id;
> >>   	int hash_len;
> >> =

> >> @@ -243,11 +337,16 @@ static int nvme_auth_dhchap_negotiate(struct
> >> nvme_ctrl *ctrl, data->napd =3D 1;
> >> =

> >>   	data->auth_protocol[0].dhchap.authid =3D NVME_AUTH_DHCHAP_AUTH_ID;
> >>   	data->auth_protocol[0].dhchap.halen =3D 3;
> >> =

> >> -	data->auth_protocol[0].dhchap.dhlen =3D 1;
> >> +	data->auth_protocol[0].dhchap.dhlen =3D 6;
> >> =

> >>   	data->auth_protocol[0].dhchap.idlist[0] =3D
> >>   	NVME_AUTH_DHCHAP_HASH_SHA256;
> >>   	data->auth_protocol[0].dhchap.idlist[1] =3D
> >>   	NVME_AUTH_DHCHAP_HASH_SHA384;
> >>   	data->auth_protocol[0].dhchap.idlist[2] =3D
> >>   	NVME_AUTH_DHCHAP_HASH_SHA512;
> >>   	data->auth_protocol[0].dhchap.idlist[3] =3D
> >>   	NVME_AUTH_DHCHAP_DHGROUP_NULL;
> >> =

> >> +	data->auth_protocol[0].dhchap.idlist[4] =3D
> >> NVME_AUTH_DHCHAP_DHGROUP_2048;
> >> +	data->auth_protocol[0].dhchap.idlist[5] =3D
> >> NVME_AUTH_DHCHAP_DHGROUP_3072;
> >> +	data->auth_protocol[0].dhchap.idlist[6] =3D
> >> NVME_AUTH_DHCHAP_DHGROUP_4096;
> >> +	data->auth_protocol[0].dhchap.idlist[7] =3D
> >> NVME_AUTH_DHCHAP_DHGROUP_6144;
> >> +	data->auth_protocol[0].dhchap.idlist[8] =3D
> >> NVME_AUTH_DHCHAP_DHGROUP_8192;
> >> =

> >>   	return size;
> >>   =

> >>   }
> >> =

> >> @@ -274,14 +373,7 @@ static int nvme_auth_dhchap_challenge(struct
> >> nvme_ctrl
> >> *ctrl, chap->status =3D NVME_AUTH_DHCHAP_FAILURE_HASH_UNUSABLE;
> >> =

> >>   		return -EPROTO;
> >>   	=

> >>   	}
> >> =

> >> -	switch (data->dhgid) {
> >> -	case NVME_AUTH_DHCHAP_DHGROUP_NULL:
> >> -		gid_name =3D "null";
> >> -		break;
> >> -	default:
> >> -		gid_name =3D NULL;
> >> -		break;
> >> -	}
> >> +	gid_name =3D nvme_auth_dhgroup_kpp(data->dhgid);
> >> =

> >>   	if (!gid_name) {
> >>   	=

> >>   		dev_warn(ctrl->device,
> >>   		=

> >>   			 "qid %d: DH-HMAC-CHAP: invalid DH group id %d\n",
> >> =

> >> @@ -290,10 +382,24 @@ static int nvme_auth_dhchap_challenge(struct
> >> nvme_ctrl *ctrl, return -EPROTO;
> >> =

> >>   	}
> >>   	if (data->dhgid !=3D NVME_AUTH_DHCHAP_DHGROUP_NULL) {
> >> =

> >> -		chap->status =3D NVME_AUTH_DHCHAP_FAILURE_DHGROUP_UNUSABLE;
> >> -		return -EPROTO;
> >> -	}
> >> -	if (data->dhgid =3D=3D NVME_AUTH_DHCHAP_DHGROUP_NULL && data->dhvlen=
 !=3D 0)
> >> {
> >> +		if (data->dhvlen =3D=3D 0) {
> >> +			dev_warn(ctrl->device,
> >> +				 "qid %d: DH-HMAC-CHAP: empty DH value\n",
> >> +				 chap->qid);
> >> +			chap->status =3D NVME_AUTH_DHCHAP_FAILURE_DHGROUP_UNUSABLE;
> >> +			return -EPROTO;
> >> +		}
> >> +		chap->dh_tfm =3D crypto_alloc_kpp(gid_name, 0, 0);
> >> +		if (IS_ERR(chap->dh_tfm)) {
> >> +			dev_warn(ctrl->device,
> >> +				 "qid %d: DH-HMAC-CHAP: failed to initialize %s\n",
> >> +				 chap->qid, gid_name);
> >> +			chap->status =3D NVME_AUTH_DHCHAP_FAILURE_DHGROUP_UNUSABLE;
> >> +			chap->dh_tfm =3D NULL;
> >> +			return -EPROTO;
> >> +		}
> >> +		chap->dhgroup_id =3D data->dhgid;
> >> +	} else if (data->dhvlen !=3D 0) {
> >> =

> >>   		dev_warn(ctrl->device,
> >>   		=

> >>   			 "qid %d: DH-HMAC-CHAP: invalid DH value for NULL =

DH\n",
> >>   			=

> >>   			chap->qid);
> >> =

> >> @@ -313,6 +419,16 @@ static int nvme_auth_dhchap_challenge(struct
> >> nvme_ctrl
> >> *ctrl, chap->hash_len =3D data->hl;
> >> =

> >>   	chap->s1 =3D le32_to_cpu(data->seqnum);
> >>   	memcpy(chap->c1, data->cval, chap->hash_len);
> >> =

> >> +	if (data->dhvlen) {
> >> +		chap->ctrl_key =3D kmalloc(data->dhvlen, GFP_KERNEL);
> >> +		if (!chap->ctrl_key)
> >> +			return -ENOMEM;
> >> +		chap->ctrl_key_len =3D data->dhvlen;
> >> +		memcpy(chap->ctrl_key, data->cval + chap->hash_len,
> >> +		       data->dhvlen);
> >> +		dev_dbg(ctrl->device, "ctrl public key %*ph\n",
> >> +			 (int)chap->ctrl_key_len, chap->ctrl_key);
> >> +	}
> >> =

> >>   	return 0;
> >>   =

> >>   }
> >> =

> >> @@ -353,10 +469,13 @@ static int nvme_auth_dhchap_reply(struct nvme_ct=
rl
> >> *ctrl, memcpy(data->rval + chap->hash_len, chap->c2,
> >> =

> >>   		       chap->hash_len);
> >>   	=

> >>   	}
> >> =

> >> -	if (chap->host_key_len)
> >> +	if (chap->host_key_len) {
> >> +		dev_dbg(ctrl->device, "%s: qid %d host public key %*ph\n",
> >> +			__func__, chap->qid,
> >> +			chap->host_key_len, chap->host_key);
> >> =

> >>   		memcpy(data->rval + 2 * chap->hash_len, chap->host_key,
> >>   		=

> >>   		       chap->host_key_len);
> >> =

> >> -
> >> +	}
> >> =

> >>   	return size;
> >>   =

> >>   }
> >> =

> >> @@ -440,23 +559,10 @@ static int nvme_auth_dhchap_failure2(struct
> >> nvme_ctrl
> >> *ctrl, int nvme_auth_select_hash(struct nvme_ctrl *ctrl,
> >> =

> >>   			  struct nvme_dhchap_context *chap)
> >>   =

> >>   {
> >> =

> >> -	char *hash_name;
> >> +	const char *hash_name, *digest_name;
> >> =

> >>   	int ret;
> >> =

> >> -	switch (chap->hash_id) {
> >> -	case NVME_AUTH_DHCHAP_HASH_SHA256:
> >> -		hash_name =3D "hmac(sha256)";
> >> -		break;
> >> -	case NVME_AUTH_DHCHAP_HASH_SHA384:
> >> -		hash_name =3D "hmac(sha384)";
> >> -		break;
> >> -	case NVME_AUTH_DHCHAP_HASH_SHA512:
> >> -		hash_name =3D "hmac(sha512)";
> >> -		break;
> >> -	default:
> >> -		hash_name =3D NULL;
> >> -		break;
> >> -	}
> >> +	hash_name =3D nvme_auth_hmac_name(chap->hash_id);
> >> =

> >>   	if (!hash_name) {
> >>   	=

> >>   		chap->status =3D NVME_AUTH_DHCHAP_FAILURE_NOT_USABLE;
> >>   		return -EPROTO;
> >> =

> >> @@ -468,26 +574,100 @@ int nvme_auth_select_hash(struct nvme_ctrl *ctr=
l,
> >> =

> >>   		chap->shash_tfm =3D NULL;
> >>   		return -EPROTO;
> >>   	=

> >>   	}
> >> =

> >> +	digest_name =3D nvme_auth_digest_name(chap->hash_id);
> >> +	if (!digest_name) {
> >> +		crypto_free_shash(chap->shash_tfm);
> >> +		chap->shash_tfm =3D NULL;
> >> +		return -EPROTO;
> >> +	}
> >> +	chap->digest_tfm =3D crypto_alloc_shash(digest_name, 0, 0);
> >> +	if (IS_ERR(chap->digest_tfm)) {
> >> +		chap->status =3D NVME_AUTH_DHCHAP_FAILURE_NOT_USABLE;
> >> +		crypto_free_shash(chap->shash_tfm);
> >> +		chap->shash_tfm =3D NULL;
> >> +		chap->digest_tfm =3D NULL;
> >> +		return -EPROTO;
> >> +	}
> >> =

> >>   	if (!chap->key) {
> >>   	=

> >>   		dev_warn(ctrl->device, "qid %d: cannot select hash, no =

key\n",
> >>   		=

> >>   			 chap->qid);
> >>   		=

> >>   		chap->status =3D NVME_AUTH_DHCHAP_FAILURE_NOT_USABLE;
> >> =

> >> +		crypto_free_shash(chap->digest_tfm);
> >> =

> >>   		crypto_free_shash(chap->shash_tfm);
> >>   		chap->shash_tfm =3D NULL;
> >> =

> >> +		chap->digest_tfm =3D NULL;
> >> =

> >>   		return -EINVAL;
> >>   	=

> >>   	}
> >>   	ret =3D crypto_shash_setkey(chap->shash_tfm, chap->key, chap-
>key_len);
> >>   	if (ret) {
> >>   	=

> >>   		chap->status =3D NVME_AUTH_DHCHAP_FAILURE_NOT_USABLE;
> >> =

> >> +		crypto_free_shash(chap->digest_tfm);
> >> =

> >>   		crypto_free_shash(chap->shash_tfm);
> >>   		chap->shash_tfm =3D NULL;
> >> =

> >> +		chap->digest_tfm =3D NULL;
> >> =

> >>   		return ret;
> >>   	=

> >>   	}
> >> =

> >> -	dev_info(ctrl->device, "qid %d: DH-HMAC_CHAP: selected hash %s\n",
> >> -		 chap->qid, hash_name);
> >> +	dev_dbg(ctrl->device, "qid %d: DH-HMAC_CHAP: selected hash %s\n",
> >> +		chap->qid, hash_name);
> >> =

> >>   	return 0;
> >>   =

> >>   }
> >> =

> >> +static int nvme_auth_augmented_challenge(struct nvme_dhchap_context
> >> *chap,
> >> +					 u8 *challenge, u8 *aug)
> >> +{
> >> +	struct crypto_shash *tfm;
> >> +	struct shash_desc *desc;
> >> +	u8 *hashed_key;
> >> +	const char *hash_name;
> >> +	int ret;
> >> +
> >> +	hashed_key =3D kmalloc(chap->hash_len, GFP_KERNEL);
> >> +	if (!hashed_key)
> >> +		return -ENOMEM;
> >> +
> >> +	ret =3D crypto_shash_tfm_digest(chap->digest_tfm, chap->sess_key,
> >> +				      chap->sess_key_len, hashed_key);
> >> +	if (ret < 0) {
> >> +		pr_debug("failed to hash session key, err %d\n", ret);
> >> +		kfree(hashed_key);
> >> +		return ret;
> >> +	}
> >> +	hash_name =3D crypto_shash_alg_name(chap->shash_tfm);
> >> +	if (!hash_name) {
> >> +		pr_debug("Invalid hash algoritm\n");
> >> +		return -EINVAL;
> >> +	}
> >> +	tfm =3D crypto_alloc_shash(hash_name, 0, 0);
> >> +	if (IS_ERR(tfm)) {
> >> +		ret =3D PTR_ERR(tfm);
> >> +		goto out_free_key;
> >> +	}
> >> +	desc =3D kmalloc(sizeof(struct shash_desc) + crypto_shash_descsize(t=
fm),
> >> +		       GFP_KERNEL);
> >> +	if (!desc) {
> >> +		ret =3D -ENOMEM;
> >> +		goto out_free_hash;
> >> +	}
> >> +	desc->tfm =3D tfm;
> >> +
> >> +	ret =3D crypto_shash_setkey(tfm, hashed_key, chap->hash_len);
> >> +	if (ret)
> >> +		goto out_free_desc;
> >> +	ret =3D crypto_shash_init(desc);
> >> +	if (ret)
> >> +		goto out_free_desc;
> >> +	crypto_shash_update(desc, challenge, chap->hash_len);
> >> +	crypto_shash_final(desc, aug);
> >> +
> >> +out_free_desc:
> >> +	kfree_sensitive(desc);
> >> +out_free_hash:
> >> +	crypto_free_shash(tfm);
> >> +out_free_key:
> >> +	kfree(hashed_key);
> >> +	return ret;
> >> +}
> >> +
> >> =

> >>   static int nvme_auth_dhchap_host_response(struct nvme_ctrl *ctrl,
> >>   =

> >>   					  struct nvme_dhchap_context *chap)
> >>   =

> >>   {
> >> =

> >> @@ -497,6 +677,16 @@ static int nvme_auth_dhchap_host_response(struct
> >> nvme_ctrl *ctrl,
> >> =

> >>   	dev_dbg(ctrl->device, "%s: qid %d host response seq %d =

transaction
> > =

> > %d\n",
> > =

> >>   		__func__, chap->qid, chap->s1, chap->transaction);
> >> =

> >> +	if (chap->dh_tfm) {
> >> +		challenge =3D kmalloc(chap->hash_len, GFP_KERNEL);
> > =

> > Again, alignment?
> =

> Again, why?

This buffer is the digest buffer of a shash_final, no? check =

crypto_shash_final and see that you could spare yourself some extra work if =

aligned.


Ciao
Stephan



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
