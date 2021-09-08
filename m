Return-Path: <SRS0=Nr0d=N6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30AE5C433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Sep 2021 10:29:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D30C660F01
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Sep 2021 10:29:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D30C660F01
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:Cc:To:From:Date:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=D9iyAa5zxD+Nj2996Mggd71PKUjAWHo6z7BkIxQmxuQ=; b=IPTgK10KscJz0bRigq6fTktvZ+
	gZSSX7bmFi4/0iqqwlNSabHja/s40JAThrPrDnkuQ3919Sbs9IYL4HZ1Fy1pSGH3o/uTATBNWsyhr
	0Kg2B8H+oXBbv6I5JXIvs8kaYdseC12/CKwYnQ9YYyiMGFX1w7/8oQCHIfmxndu8ASv7V1Xx/3I9Y
	kKS11khMYfkhysg8YANc1WrqL4Og1NGX4DJQEBSxfPbkJyyh0EuW9yDqkflFeAVJjecZKwKdNr8re
	6CmC5+QHzp7MGXCEUueYlxfISjvZ+AKQzNA71P5oMSEwoI93HmSwlWgfyUoDeOhQ6HDa+gVMqenrt
	4GHY31/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mNupb-006Pi1-9C; Wed, 08 Sep 2021 10:29:27 +0000
Received: from smtpout30.security-mail.net ([85.31.212.37]
 helo=fx306.security-mail.net)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mNupW-006PhH-JM
 for linux-nvme@lists.infradead.org; Wed, 08 Sep 2021 10:29:25 +0000
Received: from localhost (localhost [127.0.0.1])
 by fx306.security-mail.net (Postfix) with ESMTP id CF5B0399494
 for <linux-nvme@lists.infradead.org>; Wed,  8 Sep 2021 12:29:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
 s=sec-sig-email; t=1631096956;
 bh=mrltLGgxg6NVuZ3GuHaoNnFuUy5lbqrnV2ye1za3qII=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject;
 b=j27zwjBxyMOnfKt5KCMkxYWOGhuX0WDf2kG/wTqPnUfm7WTZkIZUuhBJIfPqwQChh
 ZMx3U/7j7RbjW1oATzAqm6gRM30cfN1LtpWEQuo9Vff0f8tx2TeVFa2PGS9nCji115
 DgQW+VhtzrJSuYI6cxV0CzCC8tBWa/a5vK2Jco0w=
Received: from fx306 (localhost [127.0.0.1]) by fx306.security-mail.net
 (Postfix) with ESMTP id 95F053994E5; Wed,  8 Sep 2021 12:29:16 +0200 (CEST)
Received: from zimbra2.kalray.eu (unknown [217.181.231.53]) by
 fx306.security-mail.net (Postfix) with ESMTPS id 391953994BA; Wed,  8 Sep
 2021 12:29:16 +0200 (CEST)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTPS id 1D56927E02EB; Wed,  8 Sep 2021
 12:29:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1]) by zimbra2.kalray.eu
 (Postfix) with ESMTP id 06E9427E02E5; Wed,  8 Sep 2021 12:29:16 +0200 (CEST)
Received: from zimbra2.kalray.eu ([127.0.0.1]) by localhost
 (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026) with ESMTP id
 tUESjCD4QO6e; Wed,  8 Sep 2021 12:29:15 +0200 (CEST)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTP id EB14A27E02DA; Wed,  8 Sep 2021
 12:29:15 +0200 (CEST)
X-Virus-Scanned: E-securemail, by Secumail
Secumail-id: <dc60.6138907c.37dac.0>
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 06E9427E02E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=4F334102-7B72-11EB-A74E-42D0B9747555; t=1631096956;
 bh=vJ1fkUJch1H0WlDs/VR0E8s7tC52KwoyslNr1xnmXF0=;
 h=Date:From:To:Message-ID:MIME-Version;
 b=Qis9goucMyjnlQeqgxigYc61aTK4R5moH0ON5JiZeQz6BbzXxLfikyaAua2XKR74J
 Lor9w8sK8MAfl438UXfTecK0bc6Esz6N0BmTObp3d0DWgatN+04smZx1zBoL1IZtgA
 ng86TrOPzDFqTi/8R1n/CCPCHNOZIflAHsOM0SSxTm5j2+fOVq0bEPFrIBeVrgzy8f
 2+zpJ9cBzJpfpdS3/ptLGSy/4C+hqOSEx56v0tgKIsyCnayfSqPUBlITu/dmM+RE5c
 VrR7OJQws7pvNYfq/GOpubGGxnuqpHr2Q7R3BU0Z/0cI0Qae9iNGVMVse9qcBv3tie
 Jv/I1fCYeK2Ag==
Date: Wed, 8 Sep 2021 12:29:15 +0200 (CEST)
From: Samuel Jones <sjones@kalrayinc.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-nvme
 <linux-nvme@lists.infradead.org>
Message-ID: <881640538.5931113.1631096955829.JavaMail.zimbra@kalray.eu>
In-Reply-To: <20210907204615.GA591280@dhcp-10-100-145-180.wdc.com>
References: <1058345072.5039165.1630330229081.JavaMail.zimbra@kalray.eu>
 <20210831023712.GA4046@dhcp-10-100-145-180.wdc.com>
 <1306302519.5246175.1630450012705.JavaMail.zimbra@kalray.eu>
 <6e2770ca-c0ea-872a-377e-a17fa12961d9@grimberg.me>
 <337815466.5790984.1631005553242.JavaMail.zimbra@kalray.eu>
 <20210907164236.GA367782@dhcp-10-100-145-180.wdc.com>
 <20210907204615.GA591280@dhcp-10-100-145-180.wdc.com>
Subject: Re: Command timeouts with NVMe TCP kernel driver
MIME-Version: 1.0
X-Originating-IP: [192.168.40.202]
X-Mailer: Zimbra 9.0.0_GA_3990 (ZimbraWebClient - FF70 (Linux)/9.0.0_GA_3990)
Thread-Topic: Command timeouts with NVMe TCP kernel driver
Thread-Index: YWxZx74J3GfV/7sVfSQbHtPyfrs+BQ==
X-ALTERMIMEV2_out: done
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210908_032923_121927_84232CA7 
X-CRM114-Status: GOOD (  29.71  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Sep 07, 2021 at 09:42:36AM -0700, Keith Busch wrote:
> On Tue, Sep 07, 2021 at 11:05:53AM +0200, Samuel Jones wrote:
> > Hi Sagi, Keith, all,
> > 
> > I think I have a better idea about what is happening now. First of all, answers to Sagi's questions: I have 4 controllers with 8 queues each, the VM has 16 CPUs. I was timing on kernel_sendpage. I tried your patch Sagi but it didn't make any difference. Indeed, given that the queue stops transmitting requests, I guess the RX path gets very quiet very fast.
> > 
> > After a lot of time spent timing various functions in kernel_sendpage, the only thing I was able to observe was that my thread is descheduled and not rescheduled again for a LONG time. I think what is happening is the following.:
> > 
> > 1. Userspace context grabs send_mutex via queue_rq and calls into kernel_sendpage. This context is pinned to a CPU X because that's the way my benchmark works.
> > 2. Userspace context is descheduled.
> > 3. nvme_tcp_io_work is scheduled on the same CPU X because it so happens that io_cpu == X. (I have hundreds of threads which are statically assigned to CPUs and spread over all the CPUs of the VM, so there are necessarily some userspace threads whose CPU coincides with io_cpu).
> > 4. nvme_tcp_io_work obviously can't grab send_mutex because it's held by the userspace. But because req_list is not empty, it doesn't yield but keeps on spinning in the loop until it expires.
> > 5. Since pending = true nvme_tcp_io_work re-schedules itself for immediate execution. Because it's flagged as HIGHPRI, I guess this means it is rescheduled very soon/almost immediately, and my poor userspace context doesn't get enough CPU to make reasonable forward progress. We find ourselves in a kind of livelock.
> > 
> > This seems coherent with the fact that my problem disappears if I do any one of the 3 following things:
> > 
> > 1. Modify my userspace benchmark to avoid pinning threads to CPUs => direct send path can execute on a different CPU and make forward progress
> > 2. Modify nvme-tcp to remove the "direct send" path in queue_rq and always post to the work queue => no contention between direct send path and the workqueue
> > 3. Modify the tcp wq to remove the WQ_HIGHPRI flag. => I guess this makes the scheduler more friendly towards my userspace thread
> > 
> > Does this make sense? What do you think is the best way to fix this? I guess the WQ_HIGHPRI flag is there for a reason, and that the "direct send" path can provide lower latency in some cases. What about a heuristic in io_work that will prevent it from looping indefinitely after a certain number of failed attempts to claim the send mutex?
> 
> Sounds possible. The "pending" check on the req_list was to fix a race
> condition where the io_work could miss handling a request, resulting in
> a different command time out. It sounds like that could make the io_work
> spin without having anything to do, while starving the lower priority
> task. I'll try to think of another way to handle it.

Instead of relying on io_work to determine if there's pending requests,
the queuing action can try to re-schedule it only after the send_mutex
is released, and I think that should address the issue you've described
while still fixing the IO timeout the "pending" trick was addressing.
Can you try the below patch?

Sagi, does this look okay to you?

---
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index e2ab12f3f51c..e4249b7dc056 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -274,6 +274,12 @@ static inline void nvme_tcp_send_all(struct nvme_tcp_queue *queue)
 	} while (ret > 0);
 }
 
+static inline bool nvme_tcp_queue_more(struct nvme_tcp_queue *queue)
+{
+	return !list_empty(&queue->send_list) ||
+		!llist_empty(&queue->req_list) || queue->more_requests;
+}
+
 static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req,
 		bool sync, bool last)
 {
@@ -294,9 +300,10 @@ static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req,
 		nvme_tcp_send_all(queue);
 		queue->more_requests = false;
 		mutex_unlock(&queue->send_mutex);
-	} else if (last) {
-		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
 	}
+
+	if (last && nvme_tcp_queue_more(queue))
+		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
 }
 
 static void nvme_tcp_process_req_list(struct nvme_tcp_queue *queue)
@@ -906,12 +913,6 @@ static void nvme_tcp_state_change(struct sock *sk)
 	read_unlock_bh(&sk->sk_callback_lock);
 }
 
-static inline bool nvme_tcp_queue_more(struct nvme_tcp_queue *queue)
-{
-	return !list_empty(&queue->send_list) ||
-		!llist_empty(&queue->req_list) || queue->more_requests;
-}
-
 static inline void nvme_tcp_done_send_req(struct nvme_tcp_queue *queue)
 {
 	queue->request = NULL;
@@ -1145,8 +1146,7 @@ static void nvme_tcp_io_work(struct work_struct *w)
 				pending = true;
 			else if (unlikely(result < 0))
 				break;
-		} else
-			pending = !llist_empty(&queue->req_list);
+		}
 
 		result = nvme_tcp_try_recv(queue);
 		if (result > 0)
--

Hi Keith,

Your patch works correctly on my setup, no more timeout issues. Thanks!

Sam


To declare a filtering error, please use the following link : https://www.security-mail.net/reporter.php?mid=17531.6137cf9b.62d11.0&r=sjones%40kalrayinc.com&s=kbusch%40kernel.org&o=Re%3A+Command+timeouts+with+NVMe+TCP+kernel+driver&verdict=C&c=988ab53472e1563b11ab76f9be058e442334922a





_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
