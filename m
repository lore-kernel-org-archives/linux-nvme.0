Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 909ECD68B3C
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Nov 2024 16:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SbbpoTkY5Sz/oNQeBlYIx7NMuqm6r8hCI9aC7TbAiHc=; b=ngBs/vdgDHocL62V06CjngQBcX
	Jf8mfWjNhZ9svrSAOS3EYbp6EZp/e78jNPfxaq57cuoQu8f3xkNOC5ZGvgrl9aX05kX+yK6YcCrze
	h2P6YhP7/y1VFbN3Z8ZKpa02ihQPUV8HUVzaq6F1k1Bh6rtnwVvIUhWxly9R4G4Q7W4EPiHPySTa6
	EtJskFRBnzFEoz6jibjX220Ls64e+AJF23CbJPlSfqzFpBxXhbuROiOUK+ATVSht0KcZcwIgsfND/
	tQmF9CpkZ8SxjKnDGQ+VpRmRUsZEoBFcBz5aGd+xjsj/5yuk8VDblGM1AWKTjiNwBcLXcrQMcBwqB
	SkTNmWeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBd0v-00000000CFf-0sfX;
	Thu, 14 Nov 2024 16:48:13 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBd0t-00000000CF5-1dR1
	for linux-nvme@bombadil.infradead.org;
	Thu, 14 Nov 2024 16:48:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:Subject:
	References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SbbpoTkY5Sz/oNQeBlYIx7NMuqm6r8hCI9aC7TbAiHc=; b=hIDwvn4Cyq19cSbrMhDtA/adla
	VTkSsawaQCnl1hAGTxVpqXp6FpP88ehvm9xES9AtHUVubAGHvKw/WR5CHRY0rtY2vHN4v8Kh/rd4p
	cGG2w7yJkigQ9Nq3LY5o/Fo1qyLUPG6+jz5gB1YCGwmxoIMv7qdCbow2kDOdM+BGcYYdgcw1zeScl
	oXJ4GdXFTS4pnJUKa3U29RScpBReP/Ec2EUfypcbC3PgCizDOxYZRBxrly5M55NmO4FWiTOadwaXG
	L1kFdgzM8NtmhLNcsN5HWGxNA2nsgub4P5/+jkPEkbkORWqq9WCv8WGNWRwmBekQpLaPMV3S5yVjL
	uqGg52oA==;
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBd0p-000000008PU-0lsZ
	for linux-nvme@lists.infradead.org;
	Thu, 14 Nov 2024 16:48:10 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1731602874; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=HxAG20UokXW3yPOOorXTUGh09JLZ1M29mBjXp2FVUlTPHzQajcYG1USDyUdRsbMutfS2oyU8B11AB3gvIdm/aUGfE8Z09eQBUyMwn1s2zNR/LJGy5MusX8qi6Az9zqVNj/A8PzIUOt1p6EoVDPnnuc0Q0OIglX8SvbfSBWws1hc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1731602874; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=SbbpoTkY5Sz/oNQeBlYIx7NMuqm6r8hCI9aC7TbAiHc=; 
	b=jgwwu9eRMLCrA+oft0wAp0SCr4Uco6csCL62M+NQBtj3xAms8bTm+da49Hdf+14kUDagnnLYxs2d36XSdHs1k5Ode1e719+ZGkWFWGx48Qao+aYgFZs6LQ4PBRLhXRruhFfyfYNakgWbPViDdSOGBJrsB3RdSHq8twI3sQtP/lo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=bob.beckett@collabora.com;
	dmarc=pass header.from=<bob.beckett@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1731602874;
	s=zohomail; d=collabora.com; i=bob.beckett@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-Id:Message-Id:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Reply-To;
	bh=SbbpoTkY5Sz/oNQeBlYIx7NMuqm6r8hCI9aC7TbAiHc=;
	b=g5fxLHqbehU5OOkjcuBnW8sbhh1icAY31fj2J/qbto0B+IzzM6Rnh7DXhQqT3zNT
	2rMd+x6mW8dl6l/19XbxTZvMlmSfzAqdHDguButYN6aDfQ/4XK3PriCuPfYbvJUgwgk
	lkVla528xiqPbvgH7sW6g9bMujJu8oRtose6uXOo=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1731602842571819.9473999359477; Thu, 14 Nov 2024 08:47:22 -0800 (PST)
Date: Thu, 14 Nov 2024 16:47:22 +0000
From: Robert Beckett <bob.beckett@collabora.com>
To: "Keith Busch" <kbusch@kernel.org>
Cc: "Pawel Anikiel" <panikiel@google.com>, "axboe" <axboe@kernel.dk>,
	"hch" <hch@lst.de>, "kernel" <kernel@collabora.com>,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	"linux-nvme" <linux-nvme@lists.infradead.org>,
	"sagi" <sagi@grimberg.me>
Message-Id: <1932b9283ac.128cac54392446.1193433637363614433@collabora.com>
In-Reply-To: <ZzYbYSTiMddjuVjF@kbusch-mbp>
References: <20241112195053.3939762-1-bob.beckett@collabora.com>
 <20241114113803.3571128-1-panikiel@google.com> <ZzYbYSTiMddjuVjF@kbusch-mbp>
Subject: Re: [PATCH] nvme-pci: 512 byte aligned dma pool segment quirk
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_294122_1876168745.1731602842540"
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Zoho-Virus-Status: 1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241114_164808_557598_FA34745C 
X-CRM114-Status: GOOD (  37.90  )
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

------=_Part_294122_1876168745.1731602842540
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit






 ---- On Thu, 14 Nov 2024 15:46:41 +0000  Keith Busch  wrote --- 
 > On Thu, Nov 14, 2024 at 11:38:03AM +0000, Pawel Anikiel wrote:
 > > I've been tracking down an issue that seems to be related (identical?) to
 > > this one, and I would like to propose a different fix.
 > > 
 > > I have a device with the aforementioned NVMe-eMMC bridge, and I was
 > > experiencing nvme read timeouts after updating the kernel from 5.15 to
 > > 6.6. Doing a kernel bisect, I arrived at the same dma pool commit as
 > > Robert in the original thread.
 > > 
 > > After trying out some changes in the nvme-pci driver, I came up with the
 > > same fix as in this thread: change the alignment of the small pool to
 > > 512. However, I wanted to get a deeper understanding of what's going on.
 > > 
 > > After a lot of analysis, I found out why the nvme timeouts were happening:
 > > The bridge incorrectly implements PRP list chaining.
 > > 
 > > When doing a read of exactly 264 sectors, and allocating a PRP list with
 > > offset 0xf00, the last PRP entry in that list lies right before a page
 > > boundary.  The bridge incorrectly (?) assumes that it's a pointer to a
 > > chained PRP list, tries to do a DMA to address 0x0, gets a bus error,
 > > and crashes.
 > > 
 > > When doing a write of 264 sectors with PRP list offset of 0xf00,
 > > the bridge treats data as a pointer, and writes incorrect data to
 > > the drive. This might be why Robert is experiencing fs corruption.
 > 
 > This sounds very plausible, great analysis. Curious though, even without
 > the dma pool optimizations, you could still allocate a PRP list at that
 > offset. I wonder why the problem only showed up once we optimized the
 > pool allocator.

yeah, me too. This is why I ended up at the 512 byte alignment idea.
I was speculating that maybe it has a 512 byte cache, and it caches whole 512 byte aligned blocks. So when we issue the previous segment immediately again, while it is processing the current segment, it may not have invalidated that first segment and start processing it using stale prp's that were meant for the previous block.
I'm not sure why last entry in page required to be a chain in fw would be exposed more readily by the the dmapool block stack change.

 >  
 > > So if my findings are right, the correct quirk would be "don't make PRP
 > > lists ending on a page boundary".
 > 
 > Coincidently enough, the quirk in this patch achieves that. But it's
 > great to understand why it was successful.
 > 
 > > Changing the small dma pool alignment to 512 happens to fix the issue
 > > because it never allocates a PRP list with offset 0xf00. Theoretically,
 > > the issue could still happen with the page pool, but this bridge has
 > > a max transfer size of 64 pages, which is not enough to fill an entire
 > > page-sized PRP list.
 > 
 > Thanks, this answers my question in the other thread: MDTS is too small
 > to hit the same bug with the large pool.
 > 

I hadn't appreciated the MDTS meaning that we never actually use a full page in a given transfer.
For reference, it is 6, which looks like it means only half a page will ever get used by this device. 
In case it is useful for further discussion, attached is the nvme controller identity output


------=_Part_294122_1876168745.1731602842540
Content-Type: application/octet-stream; name=nvme-id.log
Content-Transfer-Encoding: base64
X-ZM_AttachId: 139508956425410220
Content-Disposition: attachment; filename=nvme-id.log

TlZNRSBJZGVudGlmeSBDb250cm9sbGVyOgp2aWQgICAgICAgOiAweDEyMTcKc3N2aWQgICAgIDog
MHgyCnNuICAgICAgICA6IE5DRTc3N0QwMEIyMUQKbW4gICAgICAgIDogRTJNMiA2NEdCCmZyICAg
ICAgICA6IDEwMTAwMDgwCnJhYiAgICAgICA6IDUKaWVlZSAgICAgIDogMDBkMDUxCmNtaWMgICAg
ICA6IDAKICBbMzozXSA6IDAJQU5BIG5vdCBzdXBwb3J0ZWQKICBbMjoyXSA6IDAJUENJCiAgWzE6
MV0gOiAwCVNpbmdsZSBDb250cm9sbGVyCiAgWzA6MF0gOiAwCVNpbmdsZSBQb3J0CgptZHRzICAg
ICAgOiA2CmNudGxpZCAgICA6IDB4MQp2ZXIgICAgICAgOiAweDEwMzAwCnJ0ZDNyICAgICA6IDB4
N2ExMjAKcnRkM2UgICAgIDogMHgxZTg0ODAKb2FlcyAgICAgIDogMHgyMAogIFszMTozMV0gOiAw
CURpc2NvdmVyeSBMb2cgQ2hhbmdlIE5vdGljZSBOb3QgU3VwcG9ydGVkCiAgWzI3OjI3XSA6IDAJ
Wm9uZSBEZXNjcmlwdG9yIENoYW5nZWQgTm90aWNlcyBOb3QgU3VwcG9ydGVkCiAgWzE1OjE1XSA6
IDAJTm9ybWFsIE5TUyBTaHV0ZG93biBFdmVudCBOb3QgU3VwcG9ydGVkCiAgWzE0OjE0XSA6IDAJ
RW5kdXJhbmNlIEdyb3VwIEV2ZW50IEFnZ3JlZ2F0ZSBMb2cgUGFnZSBDaGFuZ2UgTm90aWNlIE5v
dCBTdXBwb3J0ZWQKICBbMTM6MTNdIDogMAlMQkEgU3RhdHVzIEluZm9ybWF0aW9uIE5vdGljZXMg
Tm90IFN1cHBvcnRlZAogIFsxMjoxMl0gOiAwCVByZWRpY3RhYmxlIExhdGVuY3kgRXZlbnQgQWdn
cmVnYXRlIExvZyBDaGFuZ2UgTm90aWNlcyBOb3QgU3VwcG9ydGVkCiAgWzExOjExXSA6IDAJQXN5
bW1ldHJpYyBOYW1lc3BhY2UgQWNjZXNzIENoYW5nZSBOb3RpY2VzIE5vdCBTdXBwb3J0ZWQKICBb
OTo5XSA6IDAJRmlybXdhcmUgQWN0aXZhdGlvbiBOb3RpY2VzIE5vdCBTdXBwb3J0ZWQKICBbODo4
XSA6IDAJTmFtZXNwYWNlIEF0dHJpYnV0ZSBDaGFuZ2VkIEV2ZW50IE5vdCBTdXBwb3J0ZWQKICBb
NzowXSA6IDB4MjAJUmVzZXJ2ZWQKCmN0cmF0dCAgICA6IDAKICBbMTk6MTldIDogMAlGbGV4aWJs
ZSBEYXRhIFBsYWNlbWVudCBOb3QgU3VwcG9ydGVkCiAgWzE1OjE1XSA6IDAJRXh0ZW5kZWQgTEJB
IEZvcm1hdHMgTm90IFN1cHBvcnRlZAogIFsxNDoxNF0gOiAwCURlbGV0ZSBOVk0gU2V0IE5vdCBT
dXBwb3J0ZWQKICBbMTM6MTNdIDogMAlEZWxldGUgRW5kdXJhbmNlIEdyb3VwIE5vdCBTdXBwb3J0
ZWQKICBbMTI6MTJdIDogMAlWYXJpYWJsZSBDYXBhY2l0eSBNYW5hZ2VtZW50IE5vdCBTdXBwb3J0
ZWQKICBbMTE6MTFdIDogMAlGaXhlZCBDYXBhY2l0eSBNYW5hZ2VtZW50IE5vdCBTdXBwb3J0ZWQK
ICBbMTA6MTBdIDogMAlNdWx0aSBEb21haW4gU3Vic3lzdGVtIE5vdCBTdXBwb3J0ZWQKICBbOTo5
XSA6IDAJVVVJRCBMaXN0IE5vdCBTdXBwb3J0ZWQKICBbODo4XSA6IDAJU1EgQXNzb2NpYXRpb25z
IE5vdCBTdXBwb3J0ZWQKICBbNzo3XSA6IDAJTmFtZXNwYWNlIEdyYW51bGFyaXR5IE5vdCBTdXBw
b3J0ZWQKICBbNjo2XSA6IDAJVHJhZmZpYyBCYXNlZCBLZWVwIEFsaXZlIE5vdCBTdXBwb3J0ZWQK
ICBbNTo1XSA6IDAJUHJlZGljdGFibGUgTGF0ZW5jeSBNb2RlIE5vdCBTdXBwb3J0ZWQKICBbNDo0
XSA6IDAJRW5kdXJhbmNlIEdyb3VwcyBOb3QgU3VwcG9ydGVkCiAgWzM6M10gOiAwCVJlYWQgUmVj
b3ZlcnkgTGV2ZWxzIE5vdCBTdXBwb3J0ZWQKICBbMjoyXSA6IDAJTlZNIFNldHMgTm90IFN1cHBv
cnRlZAogIFsxOjFdIDogMAlOb24tT3BlcmF0aW9uYWwgUG93ZXIgU3RhdGUgUGVybWlzc2l2ZSBO
b3QgU3VwcG9ydGVkCiAgWzA6MF0gOiAwCTEyOC1iaXQgSG9zdCBJZGVudGlmaWVyIE5vdCBTdXBw
b3J0ZWQKCnJybHMgICAgICA6IDAKY250cmx0eXBlIDogMAogIFs3OjJdIDogMAlSZXNlcnZlZAog
IFsxOjBdIDogMAlDb250cm9sbGVyIHR5cGUgbm90IHJlcG9ydGVkCmZndWlkICAgICA6IDAwMDAw
MDAwLTAwMDAtMDAwMC0wMDAwLTAwMDAwMDAwMDAwMApjcmR0MSAgICAgOiAwCmNyZHQyICAgICA6
IDAKY3JkdDMgICAgIDogMApudm1zciAgICAgOiAwCiAgWzE6MV0gOiAwCU5WTSBzdWJzeXN0ZW0g
Tm90IHBhcnQgb2YgYW4gRW5jbG9zdXJlCiAgWzA6MF0gOiAwCU5WTSBzdWJzeXN0ZW0gTm90IHBh
cnQgb2YgYSBTdG9yYWdlIERldmljZQoKdndjaSAgICAgIDogMAogIFs3OjddIDogMAlWUEQgV3Jp
dGUgQ3ljbGVzIFJlbWFpbmluZyBmaWVsZCBpcyBOb3QgdmFsaWQuCiAgWzY6MF0gOiAwCVZQRCBX
cml0ZSBDeWNsZXMgUmVtYWluaW5nIAoKbWVjICAgICAgIDogMAogIFsxOjFdIDogMAlOVk0gc3Vi
c3lzdGVtIE5vdCBjb250YWlucyBhIE1hbmFnZW1lbnQgRW5kcG9pbnQgb24gYSBQQ0llIHBvcnQK
ICBbMDowXSA6IDAJTlZNIHN1YnN5c3RlbSBOb3QgY29udGFpbnMgYSBNYW5hZ2VtZW50IEVuZHBv
aW50IG9uIGFuIFNNQnVzL0kyQyBwb3J0CgpvYWNzICAgICAgOiAweDYKICBbMTA6MTBdIDogMAlM
b2NrZG93biBDb21tYW5kIGFuZCBGZWF0dXJlIE5vdCBTdXBwb3J0ZWQKICBbOTo5XSA6IDAJR2V0
IExCQSBTdGF0dXMgQ2FwYWJpbGl0eSBOb3QgU3VwcG9ydGVkCiAgWzg6OF0gOiAwCURvb3JiZWxs
IEJ1ZmZlciBDb25maWcgTm90IFN1cHBvcnRlZAogIFs3OjddIDogMAlWaXJ0dWFsaXphdGlvbiBN
YW5hZ2VtZW50IE5vdCBTdXBwb3J0ZWQKICBbNjo2XSA6IDAJTlZNZS1NSSBTZW5kIGFuZCBSZWNl
aXZlIE5vdCBTdXBwb3J0ZWQKICBbNTo1XSA6IDAJRGlyZWN0aXZlcyBOb3QgU3VwcG9ydGVkCiAg
WzQ6NF0gOiAwCURldmljZSBTZWxmLXRlc3QgTm90IFN1cHBvcnRlZAogIFszOjNdIDogMAlOUyBN
YW5hZ2VtZW50IGFuZCBBdHRhY2htZW50IE5vdCBTdXBwb3J0ZWQKICBbMjoyXSA6IDB4MQlGVyBD
b21taXQgYW5kIERvd25sb2FkIFN1cHBvcnRlZAogIFsxOjFdIDogMHgxCUZvcm1hdCBOVk0gU3Vw
cG9ydGVkCiAgWzA6MF0gOiAwCVNlY3VyaXR5IFNlbmQgYW5kIFJlY2VpdmUgTm90IFN1cHBvcnRl
ZAoKYWNsICAgICAgIDogNAphZXJsICAgICAgOiA0CmZybXcgICAgICA6IDB4YQogIFs1OjVdIDog
MAlNdWx0aXBsZSBGVyBvciBCb290IFVwZGF0ZSBEZXRlY3Rpb24gTm90IFN1cHBvcnRlZAogIFs0
OjRdIDogMAlGaXJtd2FyZSBBY3RpdmF0ZSBXaXRob3V0IFJlc2V0IE5vdCBTdXBwb3J0ZWQKICBb
MzoxXSA6IDB4NQlOdW1iZXIgb2YgRmlybXdhcmUgU2xvdHMKICBbMDowXSA6IDAJRmlybXdhcmUg
U2xvdCAxIFJlYWQvV3JpdGUKCmxwYSAgICAgICA6IDAKICBbNjo2XSA6IDAJVGVsZW1ldHJ5IExv
ZyBEYXRhIEFyZWEgNCBOb3QgU3VwcG9ydGVkCiAgWzU6NV0gOiAwCUxJRCAweDAsIFNjb3BlIG9m
IGVhY2ggY29tbWFuZCBpbiBMSUQgMHg1LCAweDEyLCAweDEzIE5vdCBTdXBwb3J0ZWQKICBbNDo0
XSA6IDAJUGVyc2lzdGVudCBFdmVudCBsb2cgTm90IFN1cHBvcnRlZAogIFszOjNdIDogMAlUZWxl
bWV0cnkgaG9zdC9jb250cm9sbGVyIGluaXRpYXRlZCBsb2cgcGFnZSBOb3QgU3VwcG9ydGVkCiAg
WzI6Ml0gOiAwCUV4dGVuZGVkIGRhdGEgZm9yIEdldCBMb2cgUGFnZSBOb3QgU3VwcG9ydGVkCiAg
WzE6MV0gOiAwCUNvbW1hbmQgRWZmZWN0cyBMb2cgUGFnZSBOb3QgU3VwcG9ydGVkCiAgWzA6MF0g
OiAwCVNNQVJUL0hlYWx0aCBMb2cgUGFnZSBwZXIgTlMgTm90IFN1cHBvcnRlZAoKZWxwZSAgICAg
IDogMAogIFs3OjBdIDogMCAoMCdzIGJhc2VkKQlFcnJvciBMb2cgUGFnZSBFbnRyaWVzIChFTFBF
KQoKbnBzcyAgICAgIDogMQogIFs3OjBdIDogMSAoMCdzIGJhc2VkKQlOdW1iZXIgb2YgUG93ZXIg
U3RhdGVzIFN1cHBvcnQgKE5QU1MpCgphdnNjYyAgICAgOiAwCiAgWzA6MF0gOiAwCUFkbWluIFZl
bmRvciBTcGVjaWZpYyBDb21tYW5kcyB1c2VzIFZlbmRvciBTcGVjaWZpYyBGb3JtYXQKCmFwc3Rh
ICAgICA6IDAKICBbMDowXSA6IDAJQXV0b25vbW91cyBQb3dlciBTdGF0ZSBUcmFuc2l0aW9ucyBO
b3QgU3VwcG9ydGVkCgp3Y3RlbXAgICAgOiAzNDMKIFsxNTowXSA6IDcwIMKwQyAoMzQzIEspCVdh
cm5pbmcgQ29tcG9zaXRlIFRlbXBlcmF0dXJlIFRocmVzaG9sZCAoV0NURU1QKQoKY2N0ZW1wICAg
IDogMzUzCiBbMTU6MF0gOiA4MCDCsEMgKDM1MyBLKQlDcml0aWNhbCBDb21wb3NpdGUgVGVtcGVy
YXR1cmUgVGhyZXNob2xkIChDQ1RFTVApCgptdGZhICAgICAgOiAwCmhtcHJlICAgICA6IDAKaG1t
aW4gICAgIDogMAp0bnZtY2FwICAgOiAwClsxMjc6MF0gOiAwCglUb3RhbCBOVk0gQ2FwYWNpdHkg
KFROVk1DQVApCgp1bnZtY2FwICAgOiAwClsxMjc6MF0gOiAwCglVbmFsbG9jYXRlZCBOVk0gQ2Fw
YWNpdHkgKFVOVk1DQVApCgpycG1icyAgICAgOiAwCiBbMzE6MjRdOiAwCUFjY2VzcyBTaXplCiBb
MjM6MTZdOiAwCVRvdGFsIFNpemUKICBbNTozXSA6IDAJQXV0aGVudGljYXRpb24gTWV0aG9kCiAg
WzI6MF0gOiAwCU51bWJlciBvZiBSUE1CIFVuaXRzCgplZHN0dCAgICAgOiAwCmRzdG8gICAgICA6
IDAKZnd1ZyAgICAgIDogMAprYXMgICAgICAgOiAwCmhjdG1hICAgICA6IDAKICBbMDowXSA6IDAJ
SG9zdCBDb250cm9sbGVkIFRoZXJtYWwgTWFuYWdlbWVudCBOb3QgU3VwcG9ydGVkCgptbnRtdCAg
ICAgOiAwCiBbMTU6MF0gOiAtMjczIMKwQyAoMCBLKQlNaW5pbXVtIFRoZXJtYWwgTWFuYWdlbWVu
dCBUZW1wZXJhdHVyZSAoTU5UTVQpCgpteHRtdCAgICAgOiAwCiBbMTU6MF0gOiAtMjczIMKwQyAo
MCBLKQlNYXhpbXVtIFRoZXJtYWwgTWFuYWdlbWVudCBUZW1wZXJhdHVyZSAoTVhUTVQpCgpzYW5p
Y2FwICAgOiAwCiAgWzMxOjMwXSA6IDAJQWRkaXRpb25hbCBtZWRpYSBtb2RpZmljYXRpb24gYWZ0
ZXIgc2FuaXRpemUgb3BlcmF0aW9uIGNvbXBsZXRlcyBzdWNjZXNzZnVsbHkgaXMgbm90IGRlZmlu
ZWQKICBbMjk6MjldIDogMAlOby1EZWFsbG9jYXRlIEFmdGVyIFNhbml0aXplIGJpdCBpbiBTYW5p
dGl6ZSBjb21tYW5kIFN1cHBvcnRlZAogICAgWzI6Ml0gOiAwCU92ZXJ3cml0ZSBTYW5pdGl6ZSBP
cGVyYXRpb24gTm90IFN1cHBvcnRlZAogICAgWzE6MV0gOiAwCUJsb2NrIEVyYXNlIFNhbml0aXpl
IE9wZXJhdGlvbiBOb3QgU3VwcG9ydGVkCiAgICBbMDowXSA6IDAJQ3J5cHRvIEVyYXNlIFNhbml0
aXplIE9wZXJhdGlvbiBOb3QgU3VwcG9ydGVkCgpobW1pbmRzICAgOiAwCmhtbWF4ZCAgICA6IDAK
bnNldGlkbWF4IDogMAplbmRnaWRtYXggOiAwCmFuYXR0ICAgICA6IDAKYW5hY2FwICAgIDogMAog
IFs3OjddIDogMAlOb24temVybyBncm91cCBJRCBOb3QgU3VwcG9ydGVkCiAgWzY6Nl0gOiAwCUdy
b3VwIElEIGRvZXMgY2hhbmdlCiAgWzQ6NF0gOiAwCUFOQSBDaGFuZ2Ugc3RhdGUgTm90IFN1cHBv
cnRlZAogIFszOjNdIDogMAlBTkEgUGVyc2lzdGVudCBMb3NzIHN0YXRlIE5vdCBTdXBwb3J0ZWQK
ICBbMjoyXSA6IDAJQU5BIEluYWNjZXNzaWJsZSBzdGF0ZSBOb3QgU3VwcG9ydGVkCiAgWzE6MV0g
OiAwCUFOQSBOb24tb3B0aW1pemVkIHN0YXRlIE5vdCBTdXBwb3J0ZWQKICBbMDowXSA6IDAJQU5B
IE9wdGltaXplZCBzdGF0ZSBOb3QgU3VwcG9ydGVkCgphbmFncnBtYXggOiAwCm5hbmFncnBpZCA6
IDAKcGVscyAgICAgIDogMApkb21haW5pZCAgOiAwCm1lZ2NhcCAgICA6IDAKc3FlcyAgICAgIDog
MHg2NgogIFs3OjRdIDogMHg2CU1heCBTUSBFbnRyeSBTaXplICg2NCkKICBbMzowXSA6IDB4NglN
aW4gU1EgRW50cnkgU2l6ZSAoNjQpCgpjcWVzICAgICAgOiAweDQ0CiAgWzc6NF0gOiAweDQJTWF4
IENRIEVudHJ5IFNpemUgKDE2KQogIFszOjBdIDogMHg0CU1pbiBDUSBFbnRyeSBTaXplICgxNikK
Cm1heGNtZCAgICA6IDAKbm4gICAgICAgIDogMQpvbmNzICAgICAgOiAweDQKICBbMTA6MTBdIDog
MAlBbGwgRmFzdCBDb3B5IE5vdCBTdXBwb3J0ZWQKICBbOTo5XSA6IDAJQ29weSBTaW5nbGUgQXRv
bWljaXR5IE5vdCBTdXBwb3J0ZWQKICBbODo4XSA6IDAJQ29weSBOb3QgU3VwcG9ydGVkCiAgWzc6
N10gOiAwCVZlcmlmeSBOb3QgU3VwcG9ydGVkCiAgWzY6Nl0gOiAwCVRpbWVzdGFtcCBOb3QgU3Vw
cG9ydGVkCiAgWzU6NV0gOiAwCVJlc2VydmF0aW9ucyBOb3QgU3VwcG9ydGVkCiAgWzQ6NF0gOiAw
CVNhdmUgYW5kIFNlbGVjdCBOb3QgU3VwcG9ydGVkCiAgWzM6M10gOiAwCVdyaXRlIFplcm9lcyBO
b3QgU3VwcG9ydGVkCiAgWzI6Ml0gOiAweDEJRGF0YSBTZXQgTWFuYWdlbWVudCBTdXBwb3J0ZWQK
ICBbMToxXSA6IDAJV3JpdGUgVW5jb3JyZWN0YWJsZSBOb3QgU3VwcG9ydGVkCiAgWzA6MF0gOiAw
CUNvbXBhcmUgTm90IFN1cHBvcnRlZAoKZnVzZXMgICAgIDogMAogIFswOjBdIDogMAlGdXNlZCBD
b21wYXJlIGFuZCBXcml0ZSBOb3QgU3VwcG9ydGVkCgpmbmEgICAgICAgOiAwCiAgWzM6M10gOiAw
CUZvcm1hdCBOVk0gQnJvYWRjYXN0IE5TSUQgKEZGRkZGRkZGaCkgU3VwcG9ydGVkCiAgWzI6Ml0g
OiAwCUNyeXB0byBFcmFzZSBOb3QgU3VwcG9ydGVkIGFzIHBhcnQgb2YgU2VjdXJlIEVyYXNlCiAg
WzE6MV0gOiAwCUNyeXB0byBFcmFzZSBBcHBsaWVzIHRvIFNpbmdsZSBOYW1lc3BhY2UocykKICBb
MDowXSA6IDAJRm9ybWF0IEFwcGxpZXMgdG8gU2luZ2xlIE5hbWVzcGFjZShzKQoKdndjICAgICAg
IDogMHgxCiAgWzI6MV0gOiAwCVN1cHBvcnQgZm9yIHRoZSBOU0lEIGZpZWxkIHNldCB0byBGRkZG
RkZGRmggaXMgbm90IGluZGljYXRlZAogIFswOjBdIDogMHgxCVZvbGF0aWxlIFdyaXRlIENhY2hl
IFByZXNlbnQKCmF3dW4gICAgICA6IDAKYXd1cGYgICAgIDogMAppY3N2c2NjICAgOiAwCiAgWzA6
MF0gOiAwCU5WTSBWZW5kb3IgU3BlY2lmaWMgQ29tbWFuZHMgdXNlcyBWZW5kb3IgU3BlY2lmaWMg
Rm9ybWF0Cgpud3BjICAgICAgOiAwCiAgWzI6Ml0gOiAwCVBlcm1hbmVudCBXcml0ZSBQcm90ZWN0
IE5vdCBTdXBwb3J0ZWQKICBbMToxXSA6IDAJV3JpdGUgUHJvdGVjdCBVbnRpbCBQb3dlciBTdXBw
bHkgTm90IFN1cHBvcnRlZAogIFswOjBdIDogMAlObyBXcml0ZSBQcm90ZWN0IGFuZCBXcml0ZSBQ
cm90ZWN0IE5hbWVzcGFjZSBOb3QgU3VwcG9ydGVkCgphY3d1ICAgICAgOiAwCm9jZnMgICAgICA6
IDAKICBbMzozXSA6IDAJQ29udHJvbGxlciBDb3B5IEZvcm1hdCAzaCBOb3QgU3VwcG9ydGVkCiAg
WzI6Ml0gOiAwCUNvbnRyb2xsZXIgQ29weSBGb3JtYXQgMmggTm90IFN1cHBvcnRlZAogIFsxOjFd
IDogMAlDb250cm9sbGVyIENvcHkgRm9ybWF0IDFoIE5vdCBTdXBwb3J0ZWQKICBbMDowXSA6IDAJ
Q29udHJvbGxlciBDb3B5IEZvcm1hdCAwaCBOb3QgU3VwcG9ydGVkCgpzZ2xzICAgICAgOiAwCiBb
MTU6OF0gOiAwCVNHTCBEZXNjcmlwdG9yIFRocmVzaG9sZAogWzE6MF0gIDogMAlTY2F0dGVyLUdh
dGhlciBMaXN0cyBOb3QgU3VwcG9ydGVkCgptbmFuICAgICAgOiAwCm1heGRuYSAgICA6IDAKbWF4
Y25hICAgIDogMApvYXFkICAgICAgOiAwCnN1Ym5xbiAgICA6IAppb2Njc3ogICAgOiAwCmlvcmNz
eiAgICA6IDAKaWNkb2ZmICAgIDogMApmY2F0dCAgICAgOiAwCiAgWzA6MF0gOiAwCUR5bmFtaWMg
Q29udHJvbGxlciBNb2RlbAoKbXNkYmQgICAgIDogMApvZmNzICAgICAgOiAwCiAgWzA6MF0gOiAw
CURpc2Nvbm5lY3QgY29tbWFuZCBOb3QgU3VwcG9ydGVkCgpwcyAgICAgIDAgOiBtcDo1LjAwVyBv
cGVyYXRpb25hbCBlbmxhdDowIGV4bGF0OjAgcnJ0OjAgcnJsOjAKICAgICAgICAgICAgcnd0OjAg
cndsOjAgaWRsZV9wb3dlcjotIGFjdGl2ZV9wb3dlcjotCiAgICAgICAgICAgIGFjdGl2ZV9wb3dl
cl93b3JrbG9hZDotCnBzICAgICAgMSA6IG1wOjAuMDAyNVcgbm9uLW9wZXJhdGlvbmFsIGVubGF0
OjQwMDAgZXhsYXQ6MTAwMDAgcnJ0OjEgcnJsOjEKICAgICAgICAgICAgcnd0OjEgcndsOjEgaWRs
ZV9wb3dlcjotIGFjdGl2ZV9wb3dlcjotCiAgICAgICAgICAgIGFjdGl2ZV9wb3dlcl93b3JrbG9h
ZDotCg==
------=_Part_294122_1876168745.1731602842540--


