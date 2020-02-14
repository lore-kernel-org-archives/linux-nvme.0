Return-Path: <SRS0=f2Gy=4C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26CAFC2BA83
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Feb 2020 16:22:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2F9624756
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Feb 2020 16:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nulOjcUg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2F9624756
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=eZqi3B9Q01mGa3HfJhaH4LJDZ8e20tMMUmeUc3ZQ9eU=; b=nulOjcUgQULdCWecrFueOhiPx
	DSot0fArfE8FnfWEBeBG1Dy5lWmCLMgZZ3gC6dKBSN/9BEmpxaWNlRytgGJqKhx4Gm+dM5zr5i8Zy
	lKvUzqx9BJrp6hnpS4L+48flYvsOn/15W8sXtNbPzrEAX08IaOgW5evZAL7AJ+27RRqGRVKsontRL
	xGcz0hZGlsFZV3KmfA1da/HzH5aF/0X6bDhpIoyMNh2wWUB/GSBqITbPRcQxqWRkK3eGfbFpLYXG4
	zwcID1A6aTGFSVyXp7RPwNICUU5c777Xs4brmX10YsS7lBi0QsRiYGUDnfq4GcV9tumvDplEi/FP5
	vFy4Qm9RQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j2djb-0006I2-Ml; Fri, 14 Feb 2020 16:22:31 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j2dSB-00032o-Iq
 for linux-nvme@lists.infradead.org; Fri, 14 Feb 2020 16:04:33 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 3B00FABEA;
 Fri, 14 Feb 2020 16:04:28 +0000 (UTC)
Subject: Re: [LSF/MM/BPF TOPIC] NVMe HDD
To: Keith Busch <kbusch@kernel.org>
References: <CANo=J14resJ4U1nufoiDq+ULd0k-orRCsYah8Dve-y8uCjA62Q@mail.gmail.com>
 <20200211122821.GA29811@ming.t460p>
 <CANo=J14iRK8K3bc1g3rLBp=QTLZQak0DcHkvgZS2f=xO_HFgxQ@mail.gmail.com>
 <BYAPR04MB5816AA843E63FFE2EA1D5D23E71B0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <yq1blq3rxzj.fsf@oracle.com>
 <CANo=J16cDBUDWdV7tdY33UO0UT0t-g7jRfMVTxZpePvLew7Mxg@mail.gmail.com>
 <yq1r1yzqfyb.fsf@oracle.com> <2d66bb0b-29ca-6888-79ce-9e3518ee4b61@suse.de>
 <20200214144007.GD9819@redsun51.ssa.fujisawa.hgst.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <d043a58d-6584-1792-4433-ac2cc39526ca@suse.de>
Date: Fri, 14 Feb 2020 17:04:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200214144007.GD9819@redsun51.ssa.fujisawa.hgst.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200214_080431_923660_38A1210E 
X-CRM114-Status: GOOD (  18.06  )
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
Cc: Damien Le Moal <Damien.LeMoal@wdc.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-scsi <linux-scsi@vger.kernel.org>, Tim Walker <tim.t.walker@seagate.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Ming Lei <ming.lei@redhat.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMi8xNC8yMCAzOjQwIFBNLCBLZWl0aCBCdXNjaCB3cm90ZToKPiBPbiBGcmksIEZlYiAxNCwg
MjAyMCBhdCAwODozMjo1N0FNICswMTAwLCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6Cj4+IE9uIDIv
MTMvMjAgNToxNyBBTSwgTWFydGluIEsuIFBldGVyc2VuIHdyb3RlOgo+Pj4gUGVvcGxlIG9mdGVu
IGFydGlmaWNpYWxseSBsb3dlciB0aGUgcXVldWUgZGVwdGggdG8gYXZvaWQgdGltZW91dHMuIFRo
ZQo+Pj4gZGVmYXVsdCB0aW1lb3V0IGlzIDMwIHNlY29uZHMgZnJvbSBhbiBJL08gaXMgcXVldWVk
LiBIb3dldmVyLCBtYW55Cj4+PiBlbnRlcnByaXNlIGFwcGxpY2F0aW9ucyBzZXQgdGhlIHRpbWVv
dXQgdG8gMy01IHNlY29uZHMuIFdoaWNoIG1lYW5zIHRoYXQKPj4+IHdpdGggZGVlcCBxdWV1ZXMg
eW91J2xsIHF1aWNrbHkgc3RhcnQgc2VlaW5nIHRpbWVvdXRzIGlmIGEgZHJpdmUKPj4+IHRlbXBv
cmFyaWx5IGlzIGhhdmluZyBpc3N1ZXMga2VlcGluZyB1cCAobWVkaWEgZXJyb3JzLCBleGNlc3Np
dmUgc3BhcmUKPj4+IHRyYWNrIHNlZWtzLCBldGMuKS4KPj4+Cj4+PiBXZWxsLWJlaGF2ZWQgZGV2
aWNlcyB3aWxsIHJldHVybiBRRi9UU0YgaWYgdGhleSBoYXZlIHRyYW5zaWVudCByZXNvdXJjZQo+
Pj4gc3RhcnZhdGlvbiBvciBleGNlZWQgaW50ZXJuYWwgUW9TIGxpbWl0cy4gUUYgd2lsbCBjYXVz
ZSB0aGUgU0NTSSBzdGFjawo+Pj4gdG8gcmVkdWNlIHRoZSBudW1iZXIgb2YgSS9PcyBpbiBmbGln
aHQuIFRoaXMgYWxsb3dzIHRoZSBkcml2ZSB0byByZWNvdmVyCj4+PiBmcm9tIGl0cyBjb25nZXN0
ZWQgc3RhdGUgYW5kIHJlZHVjZXMgdGhlIHBvdGVudGlhbCBvZiBhcHBsaWNhdGlvbiBhbmQKPj4+
IGZpbGVzeXN0ZW0gdGltZW91dHMuCj4+Pgo+PiBUaGlzIG1heSBldmVuIGJlIGEgY2hhbmNlIHRv
IHJldmlzaXQgUW9TIC8gcXVldWUgYnVzeSBoYW5kbGluZy4KPj4gTlZNZSBoYXMgdGhpcyBTUSBo
ZWFkIHBvaW50ZXIgbWVjaGFuaXNtIHdoaWNoIHdhcyBzdXBwb3NlZCB0byBoYW5kbGUKPj4gdGhp
cyBraW5kIG9mIHNpdHVhdGlvbnMsIGJ1dCB0byBteSBrbm93bGVkZ2Ugbm8tb25lIGhhcyBiZWVu
Cj4+IGltcGxlbWVudGluZyBpdC4KPj4gTWlnaHQgYmUgd29ydGh3aGlsZSByZXZpc2l0aW5nIGl0
OyBndWVzcyBOVk1lIEhERHMgd291bGQgcHJvZml0IGZyb20gdGhhdC4KPiAKPiBXZSBkb24ndCBu
ZWVkIHRoYXQgYmVjYXVzZSB3ZSBkb24ndCBhbGxvY2F0ZSBlbm91Z2ggdGFncyB0byBwb3RlbnRp
YWxseQo+IHdyYXAgdGhlIHRhaWwgcGFzdCB0aGUgaGVhZC4gSWYgeW91IGNhbiBhbGxvY2F0ZSBh
IHRhZywgdGhlIHF1ZXVlIGlzIG5vdAo+IGZ1bGwuIEFuZCBjb252ZXNlbHksIG5vIHRhZyA9PSBx
dWV1ZSBmdWxsLgo+IApJdCdzIG5vdCBhIHByb2JsZW0gb24gb3VyIHNpZGUuCkl0J3MgYSBwcm9i
bGVtIG9uIHRoZSB0YXJnZXQvY29udHJvbGxlciBzaWRlLgpUaGUgdGFyZ2V0L2NvbnRyb2xsZXIg
bWlnaHQgaGF2ZSBhIG5lZWQgdG8gdGhyb3R0bGUgSS9PIChkdWUgdG8gUW9TIApzZXR0aW5ncyBv
ciBjb21wZXRpbmcgcmVzb3VyY2VzIGZyb20gb3RoZXIgaG9zdHMpLCBidXQgY3VycmVudGx5IG5v
IAptZWFucyBvZiBzaWduYWxsaW5nIHRoYXQgdG8gdGhlIGhvc3QuCldoaWNoLCBpbmNpZGVudGFs
bHksIGlzIHRoZSB1bmRlcmx5aW5nIHJlYXNvbiBmb3IgdGhlIEROUiBoYW5kbGluZyAKZGlzY3Vz
c2lvbiB3ZSBoYWQ7IE5ldEFwcCB0cmllZCB0byBtb2RlbCBRb1MgYnkgc2VuZGluZyAiTmFtZXNw
YWNlIG5vdCAKcmVhZHkiIHdpdGhvdXQgdGhlIEROUiBiaXQgc2V0LCB3aGljaCBvZiBjb3Vyc2Ug
aXMgYSB0b3RhbGx5IGRpZmZlcmVudCAKdXNlLWNhc2UgYXMgdGhlIHR5cGljYWwgJ05hbWVzcGFj
ZSBub3QgcmVhZHknIHJlc3BvbnNlIHdlIGdldCAod2l0aCB0aGUgCkROUiBiaXQgc2V0KSB3aGVu
IGEgbmFtZXNwYWNlIHdhcyB1bm1hcHBlZC4KCkFuZCB0aGF0IGlzIHdoZXJlIFNRIGhlYWQgcG9p
bnRlciB1cGRhdGVzIGNvbWVzIGluOyBpdCB3b3VsZCBhbGxvdyB0aGUgCmNvbnRyb2xsZXIgdG8g
c2lnbmFsIGJhY2sgdG8gdGhlIGhvc3QgdGhhdCBpdCBzaG91bGQgaG9sZCBvZmYgc2VuZGluZyAK
SS9PIGZvciBhIGJpdC4KU28gdGhpcyBjb3VsZCAvIG1pZ2h0IGJlIHVzZWQgZm9yIE5WTWUgSERE
cywgdG9vLCB3aGljaCBhbHNvIG1pZ2h0IGhhdmUgCmEgbmVlZCB0byBzaWduYWwgYmFjayB0byB0
aGUgaG9zdCB0aGF0IEkvT3Mgc2hvdWxkIGJlIHRocm90dGxlZC4uLgoKQ2hlZXJzLAoKSGFubmVz
Ci0tIApEci4gSGFubmVzIFJlaW5lY2tlICAgICAgICAgICAgVGVhbWxlYWQgU3RvcmFnZSAmIE5l
dHdvcmtpbmcKaGFyZUBzdXNlLmRlICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICs0OSA5
MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdtYkgsIE1heGZlbGRzdHIuIDUs
IDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdlc2Now6RmdHNmw7xo
cmVyOiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmxpbnV4LW52bWUgbWFpbGluZyBsaXN0CmxpbnV4LW52bWVAbGlzdHMu
aW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2xpbnV4LW52bWUK
