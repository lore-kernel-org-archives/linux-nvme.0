Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5124C369B1
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Apr 2025 05:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D3To97feyk05r1fbY4Pq9UyEeYoKzyV/5iJQLRIXjAk=; b=vJlg+TnJvLZGv/3Ai8AqOXNNeh
	EHlwK9G48RQ90eQ364XTYUi/Gq1OzQgknxx/nLYUtuVffr7KVXARJ9hVUXikC8DZoi11JxlmnZwH2
	uRmfoE25nQ+7VV+aTdx5vmS+2SCLSPvR8zSNHjc0E4ZkucwdZU5ppJH6gIRY9VacJZhCUw60B7D2l
	fV2kzO93XQ3DsFQ7VFRNNCYchn6Pykr9hI3QRTvwlJFwFFdhGf4h0J+pWv6DWpWbGI0p/UThJduo6
	zA2Kaj5NZuZaeoW5Hv90MLKzxcknhF+YxixTzb4kcDb/PIK9JMkpqjx6Sr2Rv/wXzCNYpbpyBAqDt
	3nVNygBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4v6T-00000008EMd-2hiQ;
	Wed, 16 Apr 2025 05:14:29 +0000
Received: from out-185.mta0.migadu.com ([2001:41d0:1004:224b::b9])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4v6Q-00000008EM0-0ts7
	for linux-nvme@lists.infradead.org;
	Wed, 16 Apr 2025 05:14:28 +0000
Message-ID: <f5eaa6c4-3676-4da3-ae47-759b9a0f357d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744780461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D3To97feyk05r1fbY4Pq9UyEeYoKzyV/5iJQLRIXjAk=;
	b=e3x7n6RH6PfR9cTODQPVEc/l6iELyWefsDOLUerJv9h+O3mmGvMZmM2wFH5UFO/Hsed243
	EbDGwtiSxA6m3FpUTFs4+0KHnqvadsl6bbhW1pYJ7YDwsqkCEG1ooMoUPeTJqusKRkfBSw
	cXvg4xO83DbuCGddmwQ7LTDBr+p6PLA=
Date: Wed, 16 Apr 2025 07:14:18 +0200
MIME-Version: 1.0
Subject: Re: [bug report] blktests nvme/061 hang with rdma transport and siw
 driver
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Bernard Metzler <BMT@zurich.ibm.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 Daniel Wagner <wagi@kernel.org>
References: <r5676e754sv35aq7cdsqrlnvyhiq5zktteaurl7vmfih35efko@z6lay7uypy3c>
 <BN8PR15MB2513CD2A5725F5A035AE905699B22@BN8PR15MB2513.namprd15.prod.outlook.com>
 <3cf845ac-fd87-4808-bb53-c4495b03e68e@linux.dev>
 <mrdhqtchtzw5f7ypno6d5g4fwh7heoyx5nyjvfak46cneprdrm@o4q2olnuq4gg>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <mrdhqtchtzw5f7ypno6d5g4fwh7heoyx5nyjvfak46cneprdrm@o4q2olnuq4gg>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250415_221426_667445_100D6678 
X-CRM114-Status: UNSURE (   9.49  )
X-CRM114-Notice: Please train this message.
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

在 2025/4/16 4:50, Shinichiro Kawasaki 写道:
> On Apr 15, 2025 / 17:00, Zhu Yanjun wrote:
>> On 15.04.25 15:09, Bernard Metzler wrote:
>>
>>> [  106.826346] rdma_rxe: loaded
>>> [  106.832164] loop: module loaded
>>> [  107.066868] run blktests nvme/061 at 2025-04-15 15:03:04
>>> [  107.081270] infiniband eno1_rxe: set active
>>> [  107.081274] infiniband eno1_rxe: added eno1
>>> [  107.089683] infiniband enp4s0f4d1_rxe: set active
>>> [  107.089687] infiniband enp4s0f4d1_rxe: added enp4s0f4d1
>>> [  107.264770] loop0: detected capacity change from 0 to 2097152
>>> [  107.267376] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
>>> [  107.271276] nvmet_rdma: enabling port 0 (10.0.0.2:4420)
>>> [  107.312957] BUG: kernel NULL pointer dereference, address: 0000000000000028
>>> [  107.312973] #PF: supervisor read access in kernel mode
>>> [  107.312979] #PF: error_code(0x0000) - not-present page
>>> [  107.312986] PGD 0 P4D 0
>>> [  107.312992] Oops: Oops: 0000 [#1] SMP PTI
>>> [  107.312999] CPU: 1 UID: 0 PID: 123 Comm: kworker/u32:4 Not tainted 6.15.0-rc2 #1 PREEMPT(undef)
>>> [  107.313008] Hardware name: LENOVO 10A6S05601/SHARKBAY, BIOS FBKTD8AUS 09/17/2019
>>> [  107.313016] Workqueue: rxe_wq do_work [rdma_rxe]
>>> [  107.313030] RIP: 0010:rxe_mr_copy+0x58/0x230 [rdma_rxe]
>>
>> Hi, Bernard
>>
>> An interesting test. Can you find the line number of
>> (rxe_mr_copy+0x58/0x230) with crash tool?
>>
>> Thus we can find what variable is becoming NULL pointer.
> 
> I observe the failure too, but I also observe the recent patch [1] avoids it.
> With the patch applied to the kernel v6.15-rc2, I no longer observe the failure
> repeating the test case 100 times using rxe driver.
> 
> [1] https://lore.kernel.org/linux-rdma/20250402032657.1762800-1-lizhijian@fujitsu.com/

Hi, Shinichiro

Your confirmation is important for us.
Thanks a lot. I am very glad that the above commit can fix the 
aforementioned problem.

Best Regards,
Zhu Yanjun



