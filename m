From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 22 Feb 2017 21:39:37 +0200
Subject: Unexpected issues with 2 NVME initiators using the same target
In-Reply-To: <1848296658.37025722.1487782361271.JavaMail.zimbra@redhat.com>
References: <08131a05-1f56-ef61-990a-7fff04eea095@gmail.com>
 <de1a559a-bf24-0d73-5fc7-148d6cd4d4e0@grimberg.me>
 <1848296658.37025722.1487782361271.JavaMail.zimbra@redhat.com>
Message-ID: <472f1b94-6618-43c9-6497-cbc72250a3a0@grimberg.me>


> Hi Sagi,
>
> Have not looked in depth here but is this maybe the GAPS issue again I bumped into where we had to revert the patch for the SRP transport.
> Would we have to do a similar revert in the NVME space or modify mlx5 where this issue exists.

We didn't add gaps support to nvme, the block layer splits gappy
io for us.
