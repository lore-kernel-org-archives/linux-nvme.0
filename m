Return-Path: <SRS0=morU=AH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C97C433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 09:53:28 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10CDC21531
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 09:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G0H2jTHo";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="cQ11bMkm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10CDC21531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=dM2nKe1fbCDp3jAiXnx4bXxNflAA4F21fI1NyLdVOk0=; b=G0H2jTHoPBbdUYuWf98cdfsWt
	ocpMzmE2aJ6JTMKgAjvBPn3Uz5sVsvXjH4nMoFtk7sg1KYCtIm3sDGspAY55+PCkpJuKhMjjDNGrm
	t55aHxPGjHBP3nI8AE0GuomD7A3QwYPD0a++yBs3DBNQmRofrqJZYfx5kAuMh6K8B5lt0j076Qi2T
	fNRcw4LepKjyPFxoE8FhYxZsfElFwI78GkYOdz1Xek5dEIYr58AvS5HzgvWwzfsJnyod1gpzMHKes
	lVuDRjo2nCEHyY9Gxo67ZMyFZVZRRo61x770uNv4POBdWpoKOkPvJd+JnvDVpi56RReNzzOFva/e3
	ORfzp7IPQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jol2x-000466-8x; Fri, 26 Jun 2020 09:53:23 +0000
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jokhQ-0002Cy-Ef
 for linux-nvme@lists.infradead.org; Fri, 26 Jun 2020 09:31:38 +0000
Received: by mail-ej1-x643.google.com with SMTP id dr13so8711828ejc.3
 for <linux-nvme@lists.infradead.org>; Fri, 26 Jun 2020 02:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=ddXcAMBJvSM3ecaTj9X80/nb/IWt2EiQ9OJyOSnERbk=;
 b=cQ11bMkmw1huw/T4Wqcuqq5K/hDTvk9EuZZQm6gdgAHqKPh7bPdzm/N7dxAoQhcPDE
 9EHyZ0TPkW8iMbLsyfY6ToVx/Cv75IWD9oz93nwLQHoY3+Hy4rS4ZcejyfiIZtoDeWYw
 boxQgf/aRq4FUQNDLlcRuaLqAhPvl/q65lkOQJuFBqJeHKk/SGP11PhTKs2COWjvOW7k
 fyAhGykm+DcXT5oXJ/4kqW7gxwFsII2OuNtnHaUW3yQe9PJO/Mm5Jd0C3lVOVoLGy+6n
 aTS4tcWBStcmPmetvHVdvqkjACVBJ4lnyL9Xr//MStJxBPfM82amNYjNV3E78m6MkZ6s
 UJsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=ddXcAMBJvSM3ecaTj9X80/nb/IWt2EiQ9OJyOSnERbk=;
 b=Y6axcLPdvL0OEjDRt2vmVRPamNkE5CP+ZWw+Tv5anWXtqPUd4m2hLSM6U+UGF+hIYs
 OuYS4Ek2AN1PpSJKqMREqk3o5PLapow5TeuButOmH6jLOMbghmNRFoboraD0cjaPCg7r
 OaLni1VoyN3p9Jk4yjwMeER+JAzf4njSD/kfyK+/ABhQIUVT0LqA0QNxMhyAWEoDdmgF
 kj5+qurFnbRXgS41mO04tGvl4n+XEG51CEDA3doZnnUMyJ2zu4vvdHgOfBYKfHvxJRCl
 Tik10TkxqtrOMALYYNpHZk8kOLqfxy3j8ms5COCPiHQolkILcw4WYMYSYPvqSQR3iJAF
 E5NA==
X-Gm-Message-State: AOAM531i9X8QIArlB8+Mxy+6hbyX4wfx0IPZ9hN0//UgSjGMSQbrBCxE
 lJT+wOF+HBeSuVQhHt0/ywSg4RP3/TKvQ4by
X-Google-Smtp-Source: ABdhPJyIBmXJTXL+VPBJYD5vpG7jKRPFc2ybxSCMDzeRny2UoOBk2Q8uf/PFB9tAwPip/KOsmm6wlw==
X-Received: by 2002:a50:e387:: with SMTP id b7mr1852356edm.190.1593154362314; 
 Thu, 25 Jun 2020 23:52:42 -0700 (PDT)
Received: from localhost (ip-5-186-127-235.cgn.fibianet.dk. [5.186.127.235])
 by smtp.gmail.com with ESMTPSA id z8sm11008152eju.106.2020.06.25.23.52.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 23:52:41 -0700 (PDT)
Date: Fri, 26 Jun 2020 08:52:41 +0200
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To: Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH 2/6] block: add support for selecting all zones
Message-ID: <20200626065241.u4fd3m7624kdsonw@mpHalley.localdomain>
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-3-javier@javigon.com>
 <CY4PR04MB375143652B4BA25F1680A91EE7930@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200626055852.ec6bfvx7mj3ucz5r@mpHalley.localdomain>
 <CY4PR04MB37515E78D85933EAFE159B0AE7930@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CY4PR04MB37515E78D85933EAFE159B0AE7930@CY4PR04MB3751.namprd04.prod.outlook.com>
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
 SelvaKumar S <selvakuma.s1@samsung.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 Kanchan Joshi <joshi.k@samsung.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Nitesh Shetty <nj.shetty@samsung.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMjYuMDYuMjAyMCAwNjozNSwgRGFtaWVuIExlIE1vYWwgd3JvdGU6Cj5PbiAyMDIwLzA2LzI2
IDE0OjU4LCBKYXZpZXIgR29uesOhbGV6IHdyb3RlOgo+PiBPbiAyNi4wNi4yMDIwIDAxOjI3LCBE
YW1pZW4gTGUgTW9hbCB3cm90ZToKPj4+IE9uIDIwMjAvMDYvMjUgMjE6MjIsIEphdmllciBHb256
w6FsZXogd3JvdGU6Cj4+Pj4gRnJvbTogSmF2aWVyIEdvbnrDoWxleiA8amF2aWVyLmdvbnpAc2Ft
c3VuZy5jb20+Cj4+Pj4KPj4+PiBBZGQgZmxhZyB0byBhbGxvdyBzZWxlY3RpbmcgYWxsIHpvbmVz
IG9uIGEgc2luZ2xlIHpvbmUgbWFuYWdlbWVudAo+Pj4+IG9wZXJhdGlvbgo+Pj4+Cj4+Pj4gU2ln
bmVkLW9mZi1ieTogSmF2aWVyIEdvbnrDoWxleiA8amF2aWVyLmdvbnpAc2Ftc3VuZy5jb20+Cj4+
Pj4gU2lnbmVkLW9mZi1ieTogU2VsdmFLdW1hciBTIDxzZWx2YWt1bWEuczFAc2Ftc3VuZy5jb20+
Cj4+Pj4gU2lnbmVkLW9mZi1ieTogS2FuY2hhbiBKb3NoaSA8am9zaGkua0BzYW1zdW5nLmNvbT4K
Pj4+PiBTaWduZWQtb2ZmLWJ5OiBOaXRlc2ggU2hldHR5IDxuai5zaGV0dHlAc2Ftc3VuZy5jb20+
Cj4+Pj4gLS0tCj4+Pj4gIGJsb2NrL2Jsay16b25lZC5jICAgICAgICAgICAgIHwgMyArKysKPj4+
PiAgaW5jbHVkZS9saW51eC9ibGtfdHlwZXMuaCAgICAgfCAzICsrLQo+Pj4+ICBpbmNsdWRlL3Vh
cGkvbGludXgvYmxrem9uZWQuaCB8IDkgKysrKysrKysrCj4+Pj4gIDMgZmlsZXMgY2hhbmdlZCwg
MTQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Pj4+Cj4+Pj4gZGlmZiAtLWdpdCBhL2Js
b2NrL2Jsay16b25lZC5jIGIvYmxvY2svYmxrLXpvbmVkLmMKPj4+PiBpbmRleCBlODdjNjAwMDRk
YzUuLjI5MTk0Mzg4YTFiYiAxMDA2NDQKPj4+PiAtLS0gYS9ibG9jay9ibGstem9uZWQuYwo+Pj4+
ICsrKyBiL2Jsb2NrL2Jsay16b25lZC5jCj4+Pj4gQEAgLTQyMCw2ICs0MjAsOSBAQCBpbnQgYmxr
ZGV2X3pvbmVfbWdtdF9pb2N0bChzdHJ1Y3QgYmxvY2tfZGV2aWNlICpiZGV2LCBmbW9kZV90IG1v
ZGUsCj4+Pj4gIAkJcmV0dXJuIC1FTk9UVFk7Cj4+Pj4gIAl9Cj4+Pj4KPj4+PiArCWlmICh6bWdt
dC5mbGFncyAmIEJMS19aT05FX1NFTEVDVF9BTEwpCj4+Pj4gKwkJb3AgfD0gUkVRX1pPTkVfQUxM
Owo+Pj4+ICsKPj4+PiAgCXJldHVybiBibGtkZXZfem9uZV9tZ210KGJkZXYsIG9wLCB6bWdtdC5z
ZWN0b3IsIHptZ210Lm5yX3NlY3RvcnMsCj4+Pj4gIAkJCQlHRlBfS0VSTkVMKTsKPj4+PiAgfQo+
Pj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2Jsa190eXBlcy5oIGIvaW5jbHVkZS9saW51
eC9ibGtfdHlwZXMuaAo+Pj4+IGluZGV4IGNjYjg5NWY5MTFiMS4uMTZiNTdmYjJiOTljIDEwMDY0
NAo+Pj4+IC0tLSBhL2luY2x1ZGUvbGludXgvYmxrX3R5cGVzLmgKPj4+PiArKysgYi9pbmNsdWRl
L2xpbnV4L2Jsa190eXBlcy5oCj4+Pj4gQEAgLTM1MSw2ICszNTEsNyBAQCBlbnVtIHJlcV9mbGFn
X2JpdHMgewo+Pj4+ICAJICogd29yayBpdGVtIHRvIGF2b2lkIHN1Y2ggcHJpb3JpdHkgaW52ZXJz
aW9ucy4KPj4+PiAgCSAqLwo+Pj4+ICAJX19SRVFfQ0dST1VQX1BVTlQsCj4+Pj4gKwlfX1JFUV9a
T05FX0FMTCwJCS8qIGFwcGx5IHpvbmUgb3BlcmF0aW9uIHRvIGFsbCB6b25lcyAqLwo+Pj4+Cj4+
Pj4gIAkvKiBjb21tYW5kIHNwZWNpZmljIGZsYWdzIGZvciBSRVFfT1BfV1JJVEVfWkVST0VTOiAq
Lwo+Pj4+ICAJX19SRVFfTk9VTk1BUCwJCS8qIGRvIG5vdCBmcmVlIGJsb2NrcyB3aGVuIHplcm9p
bmcgKi8KPj4+PiBAQCAtMzc4LDcgKzM3OSw3IEBAIGVudW0gcmVxX2ZsYWdfYml0cyB7Cj4+Pj4g
ICNkZWZpbmUgUkVRX0JBQ0tHUk9VTkQJCSgxVUxMIDw8IF9fUkVRX0JBQ0tHUk9VTkQpCj4+Pj4g
ICNkZWZpbmUgUkVRX05PV0FJVAkJKDFVTEwgPDwgX19SRVFfTk9XQUlUKQo+Pj4+ICAjZGVmaW5l
IFJFUV9DR1JPVVBfUFVOVAkJKDFVTEwgPDwgX19SRVFfQ0dST1VQX1BVTlQpCj4+Pj4gLQo+Pj4+
ICsjZGVmaW5lIFJFUV9aT05FX0FMTAkJKDFVTEwgPDwgX19SRVFfWk9ORV9BTEwpCj4+Pj4gICNk
ZWZpbmUgUkVRX05PVU5NQVAJCSgxVUxMIDw8IF9fUkVRX05PVU5NQVApCj4+Pj4gICNkZWZpbmUg
UkVRX0hJUFJJCQkoMVVMTCA8PCBfX1JFUV9ISVBSSSkKPj4+Pgo+Pj4+IGRpZmYgLS1naXQgYS9p
bmNsdWRlL3VhcGkvbGludXgvYmxrem9uZWQuaCBiL2luY2x1ZGUvdWFwaS9saW51eC9ibGt6b25l
ZC5oCj4+Pj4gaW5kZXggMDdiNWZkZTIxZDlmLi5hOGM4OWZlNThmOTcgMTAwNjQ0Cj4+Pj4gLS0t
IGEvaW5jbHVkZS91YXBpL2xpbnV4L2Jsa3pvbmVkLmgKPj4+PiArKysgYi9pbmNsdWRlL3VhcGkv
bGludXgvYmxrem9uZWQuaAo+Pj4+IEBAIC0xNTcsNiArMTU3LDE1IEBAIGVudW0gYmxrX3pvbmVf
YWN0aW9uIHsKPj4+PiAgCUJMS19aT05FX01HTVRfUkVTRVQJPSAweDQsCj4+Pj4gIH07Cj4+Pj4K
Pj4+PiArLyoqCj4+Pj4gKyAqIGVudW0gYmxrX3pvbmVfbWdtdF9mbGFncyAtIEZsYWdzIGZvciBi
bGtfem9uZV9tZ210Cj4+Pj4gKyAqCj4+Pj4gKyAqIEJMS19aT05FX1NFTEVDVF9BTEw6IFNlbGVj
dCBhbGwgem9uZXMgZm9yIGN1cnJlbnQgem9uZSBhY3Rpb24KPj4+PiArICovCj4+Pj4gK2VudW0g
YmxrX3pvbmVfbWdtdF9mbGFncyB7Cj4+Pj4gKwlCTEtfWk9ORV9TRUxFQ1RfQUxMCT0gMSA8PCAw
LAo+Pj4+ICt9Owo+Pj4+ICsKPj4+PiAgLyoqCj4+Pj4gICAqIHN0cnVjdCBibGtfem9uZV9tZ210
IC0gRXh0ZW5kZWQgem9uZWQgbWFuYWdlbWVudAo+Pj4+ICAgKgo+Pj4+Cj4+Pgo+Pj4gTkFDSy4K
Pj4+Cj4+PiBEZXRhaWxzOgo+Pj4gMSkgUkVRX09QX1pPTkVfUkVTRVQgdG9nZXRoZXIgd2l0aCBS
RVFfWk9ORV9BTEwgaXMgdGhlIHNhbWUgYXMKPj4+IFJFUV9PUF9aT05FX1JFU0VUX0FMTCwgaXNu
J3QgaXQgPyBZb3UgYXJlIGR1cGxpY2F0aW5nIGEgZnVuY3Rpb25hbGl0eSB0aGF0Cj4+PiBhbHJl
YWR5IGV4aXN0cy4KPj4+IDIpIFRoZSBwYXRjaCBpbnRyb2R1Y2VzIFJFUV9aT05FX0FMTCBhdCB0
aGUgYmxvY2sgbGF5ZXIgb25seSB3aXRob3V0IGRlZmluaW5nCj4+PiBob3cgaXQgdGllcyBpbnRv
IFNDU0kgYW5kIE5WTWUgZHJpdmVyIHVzZSBvZiBpdC4gSXMgUkVRX1pPTkVfQUxMIGluZGljYXRp
bmcgdGhhdAo+Pj4gdGhlIHpvbmUgbWFuYWdlbWVudCBjb21tYW5kcyBhcmUgdG8gYmUgZXhlY3V0
ZWQgd2l0aCB0aGUgQUxMIGJpdCBzZXQgPyBJZiB5ZXMsCj4+PiB0aGF0IHdpbGwgYnJlYWsgZGV2
aWNlLW1hcHBlci4gU2VlIHRoZSBzcGVjaWFsIGNvZGUgZm9yIGhhbmRsaW5nCj4+PiBSRVFfT1Bf
Wk9ORV9SRVNFVF9BTEwuIFRoYXQgY29kZSBpcyBpbiBwbGFjZSBmb3IgYSByZWFzb246IHRoZSB0
YXJnZXQgYmxvY2sKPj4+IGRldmljZSBtYXkgbm90IGJlIGFuIGVudGlyZSBwaHlzaWNhbCBkZXZp
Y2UuIEluIHRoYXQgY2FzZSwgYXBwbHlpbmcgYSB6b25lCj4+PiBtYW5hZ2VtZW50IGNvbW1hbmQg
dG8gYWxsIHpvbmVzIG9mIHRoZSBwaHlzaWNhbCBkcml2ZSBpcyB3cm9uZy4KPj4+IDMpIFJFUV9a
T05FX0FMTCBzZWVtcyBjb21wbGV0ZWx5IGVxdWl2YWxlbnQgdG8gc3BlY2lmeWluZyBhIHNlY3Rv
ciByYW5nZSBvZiBbMAo+Pj4gLi4gZHJpdmUgY2FwYWNpdHldLiBTbyB3aGF0IGlzIHRoZSBwb2lu
dCA/IFRoZSBjdXJyZW50IGludGVyZmFjZSBoYW5kbGVzIHRoYXQuCj4+PiBUaGF0IGlzIGhvdyB3
ZSBjaG9zZSBiZXR3ZWVuIFJFUV9PUF9aT05FX1JFU0VUIGFuZCBSRVFfT1BfWk9ORV9SRVNFVF9B
TEwgcmlnaHQgbm93Lgo+Pj4gNCkgV2l0aG91dCBhbnkgaW4ta2VybmVsIHVzZXIsIEkgZG8gbm90
IHNlZSB0aGUgcG9pbnQuIEFuZCBmb3IgYXBwbGljYXRpb25zLCBJCj4+PiBkbyBub3Qgc2VlIGFu
eSBnb29kIHVzZSBjYXNlIGZvciBkb2luZyBvcGVuIGFsbCwgY2xvc2UgYWxsLCBvZmZsaW5lIGFs
bCBvcgo+Pj4gZmluaXNoIGFsbC4gSWYgeW91IGhhdmUgYW55IHN1Y2ggZ29vZCB1c2UgY2FzZSwg
cGxlYXNlIGVsYWJvcmF0ZS4KPj4+Cj4+Cj4+IFRoZSBtYWluIHVzZSBpZiByZXNldCBhbGwsIGJ1
dCB3aXRob3V0IGhhdmluZyB0byBsb29rIHRocm91Z2ggYWxsIHpvbmVzLAo+PiBhcyBpdCBpbXBv
c2VzIGFuIG92ZXJoZWFkIHdoZW4gd2UgaGF2ZSBhIGxhcmdlIG51bWJlciBvZiB6b25lcy4gSGF2
aW5nCj4+IHRoZSBwb3NzaWJpbGl0eSB0byBvZmZsb2FkIGl0IHRvIEhXIGlzIG1vcmUgZWZmaWNp
ZW50Lgo+Pgo+PiBJIGhhZCBub3QgdGhvdWdodCBhYm91dCB0aGUgZGV2aWNlIG1hcHBlciB1c2Ug
Y2FzZS4gV291bGQgaXQgYmUgYW4KPj4gb3B0aW9uIHRvIHRyYW5zbGF0ZSB0aGlzIGludG8gUkVR
X09QX1pPTkVfUkVTRVRfQUxMIHdoZW4gd2UgaGF2ZSBhCj4+IGRldmljZSBtYXBwZXIgKG9yIGFu
eSBvdGhlciBjYXNlIHdoZXJlIHRoaXMgbWlnaHQgYnJlYWspIGFuZCB0aGVuIGxlYXZlCj4+IHRo
ZSBiaXQgZ28gdG8gdGhlIGRyaXZlciBpZiBpdCBhcHBsaWVzIHRvIHRoZSB3aG9sZSBkZXZpY2U/
Cj4KPkJ1dCBSRVFfT1BfWk9ORV9SRVNFVF9BTEwgaXMgYWxyZWFkeSBpbXBsZW1lbnRlZCBhbmQg
c3VwcG9ydGVkIGFuZCB3aWxsIHJlc2V0Cj5hbGwgem9uZXMgb2YgYSBkcml2ZSB1c2luZyBhIHNp
bmdsZSBjb21tYW5kIGlmIHRoZSBpb2N0bCBpcyBjYWxsZWQgZm9yIHRoZQo+ZW50aXJlIHNlY3Rv
ciByYW5nZSBvZiBhIHBoeXNpY2FsIGRyaXZlLiBGb3IgZGV2aWNlIG1hcHBlciB3aXRoIGEgcGFy
dGlhbAo+bWFwcGluZywgdGhlIHBlciB6b25lIHJlc2V0IGxvb3Agd2lsbCBiZSB1c2VkLiBJZiB5
b3UgaGF2ZSBubyBvdGhlciB1c2UgY2FzZSBmb3IKPnRoZSBSRVFfWk9ORV9BTEwgZmxhZywgd2hh
dCBpcyB0aGUgcG9pbnQgaGVyZSA/IFJlc2V0IGlzIGFscmVhZHkgb3B0aW1pemVkIGZvcgo+dGhl
IGFsbCB6b25lcyBjYXNlCgpPSy4gSSBtaWdodCBoYXZlIG1pc3NlZCB0aGlzLiBJIHRob3VnaHQg
d2Ugd2VyZSBzZW5kaW5nIHNldmVyYWwgY29tbWFuZHMKaW5zdGVhZCBvZiBhIHNpbmdsZSByZXNl
dCB3aXRoIHRoZSBiaXQuIEkgd2lsbCBjaGVjayBhZ2Fpbi4gVGhhbmtzIGZvcgpwb2ludGluZyBh
dCB0aGlzLgoKSmF2aWVyCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVh
ZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1u
dm1lCg==
