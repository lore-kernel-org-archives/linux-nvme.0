Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16213CD11DD
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Mar 2024 11:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=99LzP7voCnYh/Y4bbLzHy08uzA5E3NnCx/u2rSHwG+A=; b=VNLOabS0XWmaWd+6OOAGfwuo9o
	w9xQQl0F94QHvwcnhisf4hqXvJrvW6pusPs+4G2Aqe4hh92bNo23oFiUAnQO7McRbaxmrY2hAoxsK
	hVT4i+5g/u8XG3eJ0b4snHfx+k3UuSCsRD11zJTqk5j2bfTqejOvZehyphz9rYisfMsPoW7wUrXce
	yaZ1rRxpWasUyA3lQPFYaUkNRSl72LHX5ysbOZ5kePU/6liRxrzmfCIOYWdBBK7O85q88be+aB1ge
	Sd4i1w7YV326lsg7HlV5qud+ppfzeOp/ZE856M3pF07x416iKxObyuOJFmanjMVdQnFkDSN+fM3ob
	ZuNCftTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rqAWV-00000000CsH-0ltm;
	Fri, 29 Mar 2024 11:35:51 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rqAWQ-00000000Cov-3js4
	for linux-nvme@lists.infradead.org;
	Fri, 29 Mar 2024 11:35:49 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240329113537epoutp037b170215481863ea4c36a70908ef403b~BOR6y3p2l0406604066epoutp03S
	for <linux-nvme@lists.infradead.org>; Fri, 29 Mar 2024 11:35:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240329113537epoutp037b170215481863ea4c36a70908ef403b~BOR6y3p2l0406604066epoutp03S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1711712137;
	bh=99LzP7voCnYh/Y4bbLzHy08uzA5E3NnCx/u2rSHwG+A=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=belS+YeroG9oPdWWn8NXS3t1K1e3OdafX8Iz/KGC1lQUVROMOaRME2Uvgy1gWveSN
	 wX1Hqb5jMl+mZaZnQn64LeHNJCPAngu+VIYSwgai+rpGLoR3ERtPqH8LwE08ujdS+T
	 tbOnMPNsBNz34ws8e2K8XxuOkKGwJy1/4MPRDFdg=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240329113537epcas5p4a5cb2aaf19ac7afc03a4c28fdb08c04c~BOR6knDZs1875118751epcas5p4t;
	Fri, 29 Mar 2024 11:35:37 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4V5dd32n61z4x9Pv; Fri, 29 Mar
	2024 11:35:35 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	A2.52.09665.787A6066; Fri, 29 Mar 2024 20:35:35 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240329113534epcas5p3b15f2cd8483d566eecc9791b8e1ed5c7~BOR4gif_t2394523945epcas5p36;
	Fri, 29 Mar 2024 11:35:34 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240329113534epsmtrp24702b0e67bc35ccef127e11a81010352~BOR4f0rMp2556625566epsmtrp2N;
	Fri, 29 Mar 2024 11:35:34 +0000 (GMT)
X-AuditID: b6c32a4b-829fa700000025c1-a8-6606a78768ad
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	1D.2C.08390.687A6066; Fri, 29 Mar 2024 20:35:34 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240329113533epsmtip23b41d1f50ad2a799cd12237e17aec7a5~BOR2_crAe1089810898epsmtip2E;
	Fri, 29 Mar 2024 11:35:33 +0000 (GMT)
Message-ID: <e6ec5771-5377-fcb4-7fb4-0858f8f1f0ac@samsung.com>
Date: Fri, 29 Mar 2024 17:05:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [Lsf-pc] [LSF/MM/BPF ATTEND][LSF/MM/BPF TOPIC]
 Meta/Integrity/PI improvements
Content-Language: en-US
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: "axboe@kernel.dk" <axboe@kernel.dk>, josef@toxicpanda.com,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"kbusch@kernel.org" <kbusch@kernel.org>, Linux FS Devel
	<linux-fsdevel@vger.kernel.org>, lsf-pc@lists.linux-foundation.org,
	Christoph Hellwig <hch@lst.de>
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <yq1sf0b4359.fsf@ca-mkp.ca.oracle.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPJsWRmVeSWpSXmKPExsWy7bCmlm77crY0g28H+SxW3+1ns1i5+iiT
	xZ+HhhaTDl1jtNh7S9tiz96TLBbzlz1lt9j3ei+zxfLj/5gcOD0uny312LSqk81j85J6j8k3
	ljN67L7ZwObx8ektFo8JmzeyenzeJBfAEZVtk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCo
	a2hpYa6kkJeYm2qr5OIToOuWmQN0m5JCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWn
	wKRArzgxt7g0L10vL7XEytDAwMgUqDAhO2P3uq+MBdN1Ky4tW8rYwDhBtouRk0NCwETiz4FF
	jF2MXBxCArsZJSbseQXlfGKUWPnqGCuE841R4tCe+awwLd8aJrCD2EICexklNkzggih6yyjx
	+cJRZpAEr4CdxPGeVkYQm0VAVWLBpQaouKDEyZlPWEBsUYFkiZ9dB9i6GDk4hAViJJ7tcwUJ
	MwuIS9x6Mp8JxBYRMJWY/GkrG8h8ZoHHTBIf+o8wgdSzCWhKXJhcClLDKWAs8a1zNjtEr7zE
	9rdzmEHqJQRWckis3HOaEeJoF4kv/b1sELawxKvjW9ghbCmJz+/2QsWTJS7NPMcEYZdIPN5z
	EMq2l2g91c8MspcZaO/6XfoQu/gken8/ATtHQoBXoqNNCKJaUeLepKfQoBKXeDhjCZTtIfHj
	8gk2SFDNZJKYs+gI8wRGhVlIoTILyfuzkLwzC2HzAkaWVYySqQXFuempxaYFxnmp5fD4Ts7P
	3cQITrla3jsYHz34oHeIkYmD8RCjBAezkgjvzqMsaUK8KYmVValF+fFFpTmpxYcYTYHRM5FZ
	SjQ5H5j080riDU0sDUzMzMxMLI3NDJXEeV+3zk0REkhPLEnNTk0tSC2C6WPi4JRqYGqTcPv/
	sGiqv1PBvmO/QozXM0RcNXijm/6yizdz8v3G3b/4dz1rYNzLUlEnrHiy9e872ZhPvGfy1I1f
	tsW7l/nd2dhuXXihW4zvKN8GZv56v97/uZVXP5fKNp3y1bhsXK/beWjNDa55ch9uruUI+bEv
	s07g3cyQiQv+GuTIyW00e7na7fZul/4dk0yW63JesOdumyRd9LVg6RH7c2wp7xouXL3o2rL6
	3+nAY8HT23s77L9vP5CqZeGSP7Ps8evzyXGKvWzzfm5b33LEppyT8eYM8WOXz9/MbNMT4qye
	I7v7K+v6TWZfjp/5FuZsc/Jk29KN5w7+SW7yfzBz8pXPEbnfPO8Zn39zmeO2yOb+PjElluKM
	REMt5qLiRACOJYi2QgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmkeLIzCtJLcpLzFFi42LZdlhJXrdtOVuawYHzuhar7/azWaxcfZTJ
	4s9DQ4tJh64xWuy9pW2xZ+9JFov5y56yW+x7vZfZYvnxf0wOnB6Xz5Z6bFrVyeaxeUm9x+Qb
	yxk9dt9sYPP4+PQWi8eEzRtZPT5vkgvgiOKySUnNySxLLdK3S+DK2L3uK2PBdN2KS8uWMjYw
	TpDtYuTkkBAwkfjWMIG9i5GLQ0hgN6PE3+W7WSES4hLN136wQ9jCEiv/PQezhQReM0qseAHW
	zCtgJ3G8p5URxGYRUJVYcKmBGSIuKHFy5hMWEFtUIFni5Z+JYL3CAjESe7etB4szA82/9WQ+
	E4gtImAqMfnTVjaI+GMmic0/PSAOmskk8ejGaqCDODjYBDQlLkwuBanhFDCW+NY5mx2i3kyi
	a2sXI4QtL7H97RzmCYxCs5CcMQvJullIWmYhaVnAyLKKUTK1oDg3PbfYsMAoL7Vcrzgxt7g0
	L10vOT93EyM4vrS0djDuWfVB7xAjEwfjIUYJDmYlEd6dR1nShHhTEiurUovy44tKc1KLDzFK
	c7AoifN+e92bIiSQnliSmp2aWpBaBJNl4uCUamBinm36e3XutFVNH9aeWlq18T6b7MK9GxJO
	soTmyP5gNz257nFHgIbcg6kdzxJMtb7PWaEc8jKi/uCbl1cvN/FXqHJ8ObzvftkWtXub/99W
	eSt3nvP3itUF5bfv3Rd1eiVgn/knZNfPexZ9DGrq8i+Zatc2Bu5wy9jGFraq+l3Q6w1zc4/e
	DnxaabL1gS7f07AElbj3G1M/MyfzaUVOu/9L3mzO470KztoH7ha1vnjQdudeEefmu25215qe
	rD5x1CMn+3PO7PLCaL9ba76e7rHWnVE8c45sV93a8GWVJmn3Hwtz2Tw69fbdtSvpDOkPrl+R
	zJSX8F9SqnBo8kdP2fl3Jum3PPudskQz9FqyM+dufiWW4oxEQy3mouJEAKsN0QYeAwAA
X-CMS-MailID: 20240329113534epcas5p3b15f2cd8483d566eecc9791b8e1ed5c7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240222193304epcas5p318426c5267ee520e6b5710164c533b7d
References: <CGME20240222193304epcas5p318426c5267ee520e6b5710164c533b7d@epcas5p3.samsung.com>
	<aca1e970-9785-5ff4-807b-9f892af71741@samsung.com>
	<yq14jdu7t2u.fsf@ca-mkp.ca.oracle.com>
	<c196e634-7081-9d90-620c-002d3ff15dfc@samsung.com>
	<yq1sf0b4359.fsf@ca-mkp.ca.oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240329_043547_682660_3CEA1F93 
X-CRM114-Status: GOOD (  24.75  )
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

On 3/28/2024 6:00 AM, Martin K. Petersen wrote:
> 
> Hi Kanchan!
> 
>> Not sure how far it is from the requirements you may have. Feedback
>> will help. Perhaps the interface needs the ability to tell what kind
>> of checks (guard, apptag, reftag) are desired. Doable, but that will
>> require the introduction of three new RWF_* flags.
> 
> I'm working on getting my test tooling working with your series.

If it helps somehow, here is a simple application for the interface [*].
It is devoid of guard (and stuff); for that fio is better.

> But
> yes, I'll definitely need a way to set the bip flags.

Just to be clear, I was thinking of three new flags that userspace can 
pass: RWF_CHK_GUARD, RWF_CHK_APPTAG, RWF_CHK_REFTAG.
And corresponding bip flags will need to be introduced (I don't see 
anything existing). Driver will see those and convert to protocol 
specific flags.
Does this match with you what you have in mind.


>> Right. This can work for the case when host does not need to pass the
>> buffer (meta-size is equal to pi-size). But when meta-size is greater
>> than pi-size, the meta-buffer needs to be allocated. Some changes are
>> required so that Block-integrity does that allocation, without having
>> to do read_verify/write_generate.
> 
> Not sure I follow. Do you want the non-PI metadata to be passed in from
> userland but the kernel or controller to generate the PI?
> 

No, this has no connection with userland. Seems concurrent discussion 
(with the user-interface topic) will cause the confusion. Maybe this is 
better to be discussed (after some time) along with its own RFC.

[*]

#define _GNU_SOURCE

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <linux/io_uring.h>
#include "liburing.h"

/* write data/meta. read data/meta. compare data/meta buffers */
/* prerequisite: format namespace with 4KB + 8b, pi_type = 0 */

#define DATA_LEN 4096
#define META_LEN 8

int main(int argc, char *argv[])
{
         struct io_uring ring;
         struct io_uring_sqe *sqe = NULL;
         struct io_uring_cqe *cqe = NULL;
         void *wdb,*rdb;
         char wmb[META_LEN], rmb[META_LEN];
         char *data_str = "data buffer";
         char *meta_str = "meta";
         int fd, ret, blksize;
         struct stat fstat;
         unsigned long long offset = 0;

         if (argc != 2) {
                 fprintf(stderr, "Usage: %s <block-device>", argv[0]);
                 return 1;
         };

         if (stat(argv[1], &fstat) == 0) {
                 blksize = (int)fstat.st_blksize;
         } else {
                 perror("stat");
                 return 1;
         }

         if (posix_memalign(&wdb, blksize, DATA_LEN)) {
                 perror("posix_memalign failed");
                 return 1;
         }
         if (posix_memalign(&rdb, blksize, DATA_LEN)) {
                 perror("posix_memalign failed");
                 return 1;
         }

         strcpy(wdb, data_str);
         strcpy(wmb, meta_str);

         fd = open(argv[1], O_RDWR | O_DIRECT);
         if (fd < 0) {
                 printf("Error in opening device\n");
                 return 0;
         }

         ret = io_uring_queue_init(8, &ring, 0);
         if (ret) {
                 fprintf(stderr, "ring setup failed: %d\n", ret);
                 return 1;
         }

         /* write data + meta-buffer to device */
         sqe = io_uring_get_sqe(&ring);
         if (!sqe) {
                 fprintf(stderr, "get sqe failed\n");
                 return 1;
         }

         io_uring_prep_write(sqe, fd, wdb, DATA_LEN, offset);
         sqe->opcode = IORING_OP_WRITE_META;
         sqe->meta_addr = (__u64)wmb;
         sqe->meta_len = META_LEN;
         /*
          * TBD: Flags to ask for guard/apptag/reftag checks
          * sqe->rw_flags = RWF_CHK_GUARD | RWF_CHK_APPTAG | RWF_CHK_REFTAG;
          */
         ret = io_uring_submit(&ring);
         if (ret <= 0) {
                 fprintf(stderr, "sqe submit failed: %d\n", ret);
                 return 1;
         }

         ret = io_uring_wait_cqe(&ring, &cqe);
         if (!cqe) {
                 fprintf(stderr, "cqe is NULL :%d\n", ret);
                 return 1;
         }
         if (cqe->res < 0) {
                 fprintf(stderr, "write cqe failure: %d", cqe->res);
                 return 1;
         }

         io_uring_cqe_seen(&ring, cqe);

         /* read dat + meta-buffer back from device */
         sqe = io_uring_get_sqe(&ring);
         if (!sqe) {
                 fprintf(stderr, "get sqe failed\n");
                 return 1;
         }

         io_uring_prep_read(sqe, fd, rdb, DATA_LEN, offset);
         sqe->opcode = IORING_OP_READ_META;
         sqe->meta_addr = (__u64)rmb;
         sqe->meta_len = META_LEN;

         ret = io_uring_submit(&ring);
         if (ret <= 0) {
                 fprintf(stderr, "sqe submit failed: %d\n", ret);
                 return 1;
         }

         ret = io_uring_wait_cqe(&ring, &cqe);
         if (!cqe) {
                 fprintf(stderr, "cqe is NULL :%d\n", ret);
                 return 1;
         }

         if (cqe->res < 0) {
                 fprintf(stderr, "read cqe failure: %d", cqe->res);
                 return 1;
         }
         io_uring_cqe_seen(&ring, cqe);

         if (strncmp(wmb, rmb, META_LEN))
                 printf("Failure: meta mismatch!, wmb=%s, rmb=%s\n", 
wmb, rmb);

         if (strncmp(wdb, rdb, DATA_LEN))
                 printf("Failure: data mismatch!\n");

         io_uring_queue_exit(&ring);
         free(rdb);
         free(wdb);
         return 0;
}

