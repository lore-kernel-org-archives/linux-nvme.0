From: jianchao.w.wang@oracle.com (jianchao.wang)
Date: Tue, 13 Feb 2018 09:51:26 +0800
Subject: [PATCH] nvme-pci: drain the entered requests after ctrl is
 shutdown
In-Reply-To: <20180212191519.GD16255@localhost.localdomain>
References: <1518440222-652-1-git-send-email-jianchao.w.wang@oracle.com>
 <b466996e-b00a-e848-25a0-e6ba768a573f@grimberg.me>
 <20180212191519.GD16255@localhost.localdomain>
Message-ID: <23035bb1-3548-34ba-4d38-3977b0bbbb8b@oracle.com>

Hi Keith andn Sagi

Thanks for your kindly response and comment on this.

On 02/13/2018 03:15 AM, Keith Busch wrote:
> On Mon, Feb 12, 2018@08:43:58PM +0200, Sagi Grimberg wrote:
>>
>>> Currently, we will unquiesce the queues after the controller is
>>> shutdown to avoid residual requests to be stuck. In fact, we can
>>> do it more cleanly, just wait freeze and drain the queue in
>>> nvme_dev_disable and finally leave the queues quiesced.
>>
>> Does this fix a bug? What is the benefit of leaving the queues
>> quiesced in shutdown?
> 
> This doesn't appear to fix anything. The things this patch does do are
> either unnecessary (quiece), or already done elsewhere (wait freeze).
> 

Yes, this patch doesn't fix any bug. Since we will let the request to be drained
for shutdown case to avoid to be stuck, why not do it in nvme_dev_disable and 
then quiesce the queue again. In nvme_dev_disable, we unquiesce the queues finally,
it looks really something odd. And always give me a feeling that something is still
ongoing and not completed....It looks like something is leaking.... ;)

Why not we complete it in nvme_dev_disable ?

Thanks
Jianchao
