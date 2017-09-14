From: gpiccoli@linux.vnet.ibm.com (Guilherme G. Piccoli)
Date: Thu, 14 Sep 2017 14:02:15 -0300
Subject: [PATCH v2] nvme-fabrics: Prevent KATO to be set as 0
In-Reply-To: <89ebdefc-6fc7-77ad-d483-ef2befb9815d@grimberg.me>
References: <20170829220346.19424-1-gpiccoli@linux.vnet.ibm.com>
 <d67a9ef4-8c01-f842-3eed-4ef873c22dfd@grimberg.me>
 <194a3a6e-0936-b5e4-33b4-8b4335e7887b@linux.vnet.ibm.com>
 <5be8a934-0695-55fc-0a80-1794cefd6a96@linux.vnet.ibm.com>
 <89ebdefc-6fc7-77ad-d483-ef2befb9815d@grimberg.me>
Message-ID: <6e0e91e4-7eec-2369-346b-4a36e2f8976b@linux.vnet.ibm.com>

On 09/06/2017 06:30 AM, Sagi Grimberg wrote:
> Its just a simple way to test that the target does comply to the kato
> by not sending it a keep-alive and wait for it to teardown the 
> controller, seems useful to keep to have a sanity check that it
> doesn't break.
> 
> So lets go with (a)
> 

Thanks a lot Sagi for the good explanation.
Just sent a V3.

Cheers,


Guilherme
