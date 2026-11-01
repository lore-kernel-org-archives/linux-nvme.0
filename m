Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8A8606A324
	for <linux-nvme@archiver.kernel.org>; Sun,  1 Nov 2026 21:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=n/utqGbI;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IqgwzmVJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=Pc3GiBdHBzAU2POzA3ftyLpA7GZLhktCeJnyoGOhTnc=; b=n/utqGbI0d6gUPd4tjOXvt1yQF
	j5TIRQKyRtbegGikP/q+JHhmnm3RT257Nw60xTzSipXXOla1enpYISz/ZKUjva+Z4w9vg6zOHT55l
	TiSMWm96s8Ky8EXer4+TRgwaqmdKJaR0siGyDbNdJFN/qKDCCNjJ/DJ676y423xz6TVt6s/GuVW9w
	eC9UscDFp1pPbL61ip3J8hemMe/5fWbf+TCtSxzOUQDdJQjOW3RwKwN8oY2/JIlgoBlnqs7nRWCfN
	HAUuGMmv8oj8rN1IVvsi4EYHAyT4bv9TT/msSgLYIMq9Dr3VTaT3B0ETDh3ld7Zk1XnLOeeyLpj9s
	4O2NMKeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNdRt-0000000EvmG-09RB;
	Sun, 01 Nov 2026 21:50:45 +0000
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNdRm-0000000Evls-2ZwY
	for linux-nvme@lists.infradead.org;
	Sun, 01 Nov 2026 21:50:40 +0000
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-8b0d63f60bcso18189857b3.3
        for <linux-nvme@lists.infradead.org>; Sun, 01 Nov 2026 13:50:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793569836; cv=none;
        d=google.com; s=arc-20260327;
        b=dkSZwojYq7KOX4oz8K0KRWHjUFWeCVGmgvZmQAUc2A/Q9gZzLyx7uVwh23T+fKTLYP
         SGyg1djusVaddFKbHi5dI77JNCbvQJcGgirp/PZ48M/lwXtcNWjo43WHTJ9MMro6Ok0z
         /wDtEtJAMDLdj6I8JJ/e/EKWGQ65kF4K9dOZKg0ajZyIP5rTlBXhbcTyEDpB6e8pHH7f
         SJ2NHNunMf0CHoanvbL4ql7/kBEZXzcqGrYgijnS7ecOWsTcQNMPd1TZa76C5JznWHlT
         fr7plj/TzJ06GwuJQzVLWtdv7t/yEZPFAqsAIxYzMQuwJnbK++/B+vmbKkOfb/79Fjs8
         5OnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Pc3GiBdHBzAU2POzA3ftyLpA7GZLhktCeJnyoGOhTnc=;
        fh=9jiW/faBmeLhGkDgLLZFXLod06/uo+OKkD2vWsbEkGc=;
        b=OIC7Xc2MImbzz7ocv4vflDNPymLGJNZYJx+wugs6QZThKP4y/6cwTO7Wl8WOF3VvYV
         Q9C3y2p0VXjjO5Is/cf8HXC8REUS4zuQq2pfB93hFw/+F2A2An5dtRf9UauFY2UWl22j
         oCeNxF10IfCWL5TnJtzCSDHlCc2AzHQyrJKhExNloCEYbzVnqh57aoRU68qXZ1mu56ex
         VJlh3ZbgvYp8gXEzmxThHHgs8/dAamGW/GhoBDi+ibzgCpi+hWQ6Mf6ygkKoIFIGQ85D
         nIKDa1ax8HMfmtb+flSEedQ+8DuLI+2D+NcujdSHkZQ73pImqIrI7qoCouJ68e+06L7F
         h6Ww==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793569836; x=1794174636; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pc3GiBdHBzAU2POzA3ftyLpA7GZLhktCeJnyoGOhTnc=;
        b=IqgwzmVJEBn040NSdGZuHsY4pqUPQyFGxAIPQZALe74A+/RuDjHNX65TFHgMRK8emv
         g4KfX+0jcCFY7XXyVqnkmlrapzNYQR4SVE2g02RztvfUNwhV9ZBa/PjPF6e1uYfVqo9e
         86XczA//0v/RwU0XIZaOb1BUCcvGVoYg2eK2D4ZDsD12eAmqgrREskr5EFkzBhVKNzr5
         6EyrdAEWMHc/v3Bz5bYF/4Ik9AW4fjGPsxpL834KqoUCzHtxPX0q9i/1e0hGL0f25Phr
         izOOFDXuRRoJWttbi9hnj9CWMlmA32Pqc1/AKRuB28MDNVbYIAx2KyvzILw7T+WjXJ+d
         AL9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793569836; x=1794174636;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Pc3GiBdHBzAU2POzA3ftyLpA7GZLhktCeJnyoGOhTnc=;
        b=TC3+61CPjaMjku4VTKUL6b6B38GPVF2qUH/ktBZKY7bxuljIJkym7EaSntzAiNWcEm
         yQOPu4mwK64/+TnGJqgY7px+6zr7wh0u8HADM0twXZcp+hYkpmIYmHw4xcFrzq3cKWtp
         6rqqR1sqFUzXXmY2KDHoH2ShO2c/TzdM3vAUKe0ByZX0ieK/FS9acbkRvkF9dFNpLi0Y
         fIlKCYjegOOAgUczkpf3GsGOWDdiKsMXyqov9UBlLD5uMkqujQ6m7C5HqOJdJJTLp6oq
         laLepawVk1fwsWpW8NQhaBEDY23IzkDgLLyMMKv2LBCV3eVMIOB6MxB6KRoQs9irpY4Q
         i6nA==
X-Gm-Message-State: APuU4Z85NEFw0TBjdmQoGsrDuKSJ0i/u1j0JTcEx/28S6PaSjsGTbguO
	KSa76RtB1tcjI/nlzHvvQVTpYEMLkNdjO0Zb5/iSXRDJuqEuAqo7fRfNToCqukG2Fph/zcaL+Yw
	Szjq5GQc+IaBJDodu6KCusBGqAJYvT5mhyH93
X-Gm-Gg: AYBFou0QumglmEBJO+5TNUmqAzkHRllh0+udj8uZ4h0KHfsJHogtIREIodtpRxIfCIc
	kzF6PP6lSs30nKyUsxtvHDHJVXfaHI4V40Jz50XWQTejQaZrDkIfbdE/wEYx2VG9BDdhb8bnw6L
	4l9xsidNUS9NnnFFJqW0n/5PTKozR73D1jSDMVrx8TKCXrl+flQGEW/YJAa8YievAXRxo6gtVPf
	cqUKmMGTILhALz+SyQ5tc5CQ7BSJpT1/CqqRO0KH2JwoBVyfqnmXBX+KK+z9ojZ46zxWAKOAB98
	YSdpqjTiCVSCFXebMQmIE0qQDTa5m1PU5sxSyFFf0m3/P3RXWq9Mb4TBTtn50mqzPXBcRjpgeW6
	mBH+UorIamnM9c9kspHepIgz0dXkkHgtI1vCzoMRztFIDIOv8mVJnG7Y0HaSbnyw2LtIbae/Y88
	bGSjvm3XvWYm0DdSFOkA==
X-Received: by 2002:a05:690c:a011:b0:8b0:d438:a024 with SMTP id
 00721157ae682-8b2b67238edmr46142087b3.37.1793569836142; Sun, 01 Nov 2026
 13:50:36 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Omar Alzand <omaribrahimfadel@gmail.com>
Date: Mon, 2 Nov 2026 00:50:25 +0300
X-Gm-Features: AclHuK8_3zL-0lyopiwxlCtWqlQeTWWxeSmwtoXODQ3glHUxaKartZHBqFYybRw
Message-ID: <CALJMncxA-=OFc05Ht74hWnia8-sCd5yLn5hK+KfnoHMO_sbzSQ@mail.gmail.com>
Subject: nvme-pci: Micron 2200 (1344:5410) needs NVME_QUIRK_DMAPOOL_ALIGN_512
To: linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Bean Huo <beanhuo@micron.com>
Content-Type: multipart/mixed; boundary="000000000000f6ce99065f3e0428"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261101_135038_712817_A0F3AD86 
X-CRM114-Status: GOOD (  18.33  )
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000f6ce99065f3e0428
Content-Type: text/plain; charset="UTF-8"

Hello,

My Micron 2200V returns a bad last page on reads of exactly 33 pages
(132 KiB). Setting NVME_QUIRK_DMAPOOL_ALIGN_512 through the nvme.quirks
parameter stopped it in my testing. I think 1344:5410 needs the same
quirk as the Micron 4100AT, added by Bean Huo's patch "nvme-pci: add
NVME_QUIRK_DMAPOOL_ALIGN_512 for Micron 4100AT".

Hardware and software:

  Laptop:    Dell Latitude 5510, BIOS 1.43.0, i7-10610U
  Drive:     Micron_2200V_MTFDHBA512TCK, firmware P1MA0V4
  PCI ID:    1344:5410 (lspci names it "2200S NVMe SSD [Cassandra]")
  Kernel:    7.2.9-1-MANJARO
  IOMMU:     DMA domain type Translated
             ("Intel-IOMMU force enabled due to platform opt in")
  Queue:     max_sectors_kb 512, max_segments 129, scheduler none

Symptom:

Btrfs logged intermittent "csum failed" read errors, while a read-only
scrub found nothing and retrying the read succeeded. The journal shows
these errors on 6.18.x as well, from April 2026 onward. The quirks
parameter isn't available in my 6.18.55 build, so I could only test the
fix on 7.2.9.

Raw device test:

This test bypasses the filesystem. It builds a reference copy of each
location with single-page O_DIRECT reads. Then 8 threads read N pages
with O_DIRECT from /dev/nvme0n1 into a buffer pre-filled with 0xAA,
while 8 more threads issue mixed-size reads in the background. Each
size ran for 12 seconds.

  pages    KiB    reads     bad pages
      4     16    89389     0
      8     32    80764     0
     16     64    59585     0
     31    124    34906     0
     32    128    23515     0
     33    132    17715     1001, all at page 33
     34    136    13735     0
     35    140    12047     0
     40    160     9864     0
     64    256     6535     0
     65    260     5972     0
    128    512     3427     0

The failure rate at 33 pages is 5.65%, near 1 in 16. That would fit
one of the sixteen 256-byte blocks in a dmapool page being affected,
but I haven't confirmed this.

A 33-page read needs a PRP list of 32 entries, which exactly fills a
256-byte small-pool descriptor. That would make page 33 the final entry
in the list.

In the two bad pages I sampled, 3584 of the 4096 bytes still held the
0xAA marker, so that data never reached the buffer. Where it went, I
don't know.

Differences from the 4100AT description:

That patch says the IOMMU faults the command. I saw no DMAR faults and
no nvme errors in the kernel log, and the reads returned success. So
this may not be identical, and I can't rule out the undelivered data
having gone somewhere else.

Other checks:

 - Setting max_sectors_kb to 128 gave 0 bad pages in 86008 reads
   requested at 33 pages, because those reads get split.
 - Writes looked clean. 2015 write requests of 33 pages to a nodatacow
   file under O_DIRECT, each read back page by page, had 0 bad pages.
 - SMART reports 0 media errors and 100% available spare.
 - fwupd offers no newer firmware for this drive.

With the quirk:

I booted with nvme.quirks=1344:5410:dmapool_align_512. The controller's
quirks file then listed dmapool_align_512, and max_sectors_kb was back
to 512.

  pages    reads     bad pages
     32    47785     0
     33   133280     0
     34    32537     0

At the earlier rate, about 7500 bad pages would be expected at 33
pages. This run used a separate test program with longer runs for 33
pages, but the same read and background load pattern. Reading all of
/usr and /opt with a cold cache also gave 0 Btrfs checksum errors, and
the kernel log showed no faults.

Suggested change, after the existing 1344:5407 entry in nvme_id_table.
I tested the quirk through the module parameter, not this table entry:

{ PCI_DEVICE(0x1344, 0x5410), /* Micron 2200 */
.driver_data = NVME_QUIRK_DMAPOOL_ALIGN_512, },

I have only tested one drive, a 2200V. Other models may share this PCI
ID, and I don't know whether a firmware-specific condition is involved.
Bean, could you check that against what Micron knows about this
erratum?

The test program is attached (read-only, run as root). I can run other
tests or try a patch if that helps.

I used Claude, an AI assistant, to help design the tests and write this
report. The numbers come from runs on my laptop.

Thanks,
Omar Alzand
omaribrahimfadel@gmail.com

--000000000000f6ce99065f3e0428
Content-Type: text/plain; charset="US-ASCII"; name="nvme-33page-test.py.txt"
Content-Disposition: attachment; filename="nvme-33page-test.py.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_mvyd4a5d0>
X-Attachment-Id: f_mvyd4a5d0

IyEvdXNyL2Jpbi9weXRob24zIC1JCiIiIlJhdyByZWFkIHRlc3QgZm9yIHRoZSBNaWNyb24gMjIw
MCAzMy1wYWdlIFBSUC1saXN0IGZhdWx0LiBSZWFkLW9ubHkuIFJ1biBhcyByb290LgpSZWFkcyAz
MiwgMzMgYW5kIDM0IHBhZ2UgcmVxdWVzdHMgdW5kZXIgbWl4ZWQgbG9hZCBhbmQgY29tcGFyZXMg
ZWFjaCBwYWdlIHdpdGggYSByZWZlcmVuY2UuIiIiCmltcG9ydCBvcyxtbWFwLHJhbmRvbSx0aHJl
YWRpbmcsdGltZSxjb2xsZWN0aW9ucwpQRz00MDk2OyBERVY9Ii9kZXYvbnZtZTBuMSI7IHJhbmRv
bS5zZWVkKDcpOyBOPTMwMDsgTUFYUD0zNApwcz1pbnQob3BlbigiL3N5cy9jbGFzcy9ibG9jay9u
dm1lMG4xcDQvc3RhcnQiKS5yZWFkKCkpCnByaW50KCJxdWlya3M6IixvcGVuKCIvc3lzL2NsYXNz
L252bWUvbnZtZTAvcXVpcmtzIikucmVhZCgpLnN0cmlwKCksInwgbWF4X3NlY3RvcnNfa2I6Iixv
cGVuKCIvc3lzL2Jsb2NrL252bWUwbjEvcXVldWUvbWF4X3NlY3RvcnNfa2IiKS5yZWFkKCkuc3Ry
aXAoKSkKZmQ9b3Mub3BlbihERVYsb3MuT19SRE9OTFl8b3MuT19ESVJFQ1QpOyBsb2NzPVtwcyo1
MTIrcmFuZG9tLnJhbmRyYW5nZSgwLDI1PDwxOCkqUEcgZm9yIF8gaW4gcmFuZ2UoTildOyBvbmU9
bW1hcC5tbWFwKC0xLFBHKTsgcmVmcz1bXQpmb3IgbCBpbiBsb2NzOgogICAgcj1ieXRlYXJyYXko
KQogICAgZm9yIGkgaW4gcmFuZ2UoTUFYUCk6IG9zLnByZWFkdihmZCxbb25lXSxsK2kqUEcpOyBy
Kz1ieXRlcyhvbmVbOlBHXSkKICAgIHJlZnMuYXBwZW5kKGJ5dGVzKHIpKQpkZWYgd29ya2VyKHAs
c3RvcCxzdCxzKToKICAgIGc9cmFuZG9tLlJhbmRvbShzKTsgbj1wKlBHOyBiPW1tYXAubW1hcCgt
MSxuKTsgZj1vcy5vcGVuKERFVixvcy5PX1JET05MWXxvcy5PX0RJUkVDVCk7IG09YiJceEFBIipu
CiAgICB3aGlsZSBub3Qgc3RvcC5pc19zZXQoKToKICAgICAgICBpPWcucmFuZHJhbmdlKE4pOyBi
LnNlZWsoMCk7IGIud3JpdGUobSk7IG9zLnByZWFkdihmLFtiXSxsb2NzW2ldKTsgc3RbInJlYWRz
Il0rPTEKICAgICAgICBpZiBieXRlcyhiWzpuXSkhPXJlZnNbaV1bOm5dOgogICAgICAgICAgICBm
b3IgayBpbiByYW5nZShwKToKICAgICAgICAgICAgICAgIGlmIGJbaypQRzooaysxKSpQR10hPXJl
ZnNbaV1baypQRzooaysxKSpQR106IHN0W2srMV0rPTEKZGVmIG5vaXNlKHN0b3Ascyk6CiAgICBn
PXJhbmRvbS5SYW5kb20ocyk7IGY9b3Mub3BlbihERVYsb3MuT19SRE9OTFl8b3MuT19ESVJFQ1Qp
OyBicz1bbW1hcC5tbWFwKC0xLHAqUEcpIGZvciBwIGluICgzLDUsNyw5LDE2LDIwLDY0KV0KICAg
IHdoaWxlIG5vdCBzdG9wLmlzX3NldCgpOiBvcy5wcmVhZHYoZixbZy5jaG9pY2UoYnMpXSxsb2Nz
W2cucmFuZHJhbmdlKE4pXSkKZm9yIHAsc2VjIGluICgoMzIsMTApLCgzMywzMCksKDM0LDEwKSk6
CiAgICBzdG9wPXRocmVhZGluZy5FdmVudCgpOyBzdD1jb2xsZWN0aW9ucy5Db3VudGVyKCkKICAg
IHRzPVt0aHJlYWRpbmcuVGhyZWFkKHRhcmdldD13b3JrZXIsYXJncz0ocCxzdG9wLHN0LHMpKSBm
b3IgcyBpbiByYW5nZSg4KV0rW3RocmVhZGluZy5UaHJlYWQodGFyZ2V0PW5vaXNlLGFyZ3M9KHN0
b3AsMTAwK3MpKSBmb3IgcyBpbiByYW5nZSg4KV0KICAgIFt0LnN0YXJ0KCkgZm9yIHQgaW4gdHNd
OyB0aW1lLnNsZWVwKHNlYyk7IHN0b3Auc2V0KCk7IFt0LmpvaW4oKSBmb3IgdCBpbiB0c10KICAg
IHByaW50KGYie3B9IHBhZ2VzOiByZWFkcyB7c3RbJ3JlYWRzJ119LCBiYWQgcGFnZXMgYnkgcG9z
aXRpb24geyB7azp2IGZvciBrLHYgaW4gc3QuaXRlbXMoKSBpZiBrIT0ncmVhZHMnfSB9IixmbHVz
aD1UcnVlKQo=
--000000000000f6ce99065f3e0428--

