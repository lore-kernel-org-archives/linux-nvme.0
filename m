From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 20 Sep 2017 14:09:26 +0300
Subject: [PATCH v3 3/3] nvme_fc: Avoid duplicate associations between same
 port pairs
In-Reply-To: <0fc47d1d-88d3-c598-1ff2-24488c6b0789@gmail.com>
References: <20170914173843.3195-1-jsmart2021@gmail.com>
 <20170914173843.3195-4-jsmart2021@gmail.com>
 <20170918161219.GB310@infradead.org>
 <7f610102-562c-18e0-659a-ff06b0186ac2@broadcom.com>
 <20170918231715.GB12410@infradead.org>
 <0fc47d1d-88d3-c598-1ff2-24488c6b0789@gmail.com>
Message-ID: <24b9c725-3252-125d-5beb-6efc6476f2c3@grimberg.me>


> So we're on the same page - I'll add the option for "check for 
> duplicates" to the cli,

Agree its useful to have

> which will pass it on to the kernel, but the 
> implementation of the check will be in the kernel in each transport.
> 
> By keeping the check in the kernel it will:
> - avoid race conditions of what the "active controller" list is between 
> user and kernel space
> - keep transport-port specific knowledge of what connect fields are 
> meaningful in the transport,
> - avoids adding any infrastructure to get the connect fields into user 
> space if the cli were to do the checking.

Also agree here.
