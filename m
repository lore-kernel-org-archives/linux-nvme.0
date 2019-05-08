From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 8 May 2019 22:28:35 +0000
Subject: [RFC PATCH] nvme: guard ctrl->state by lock
References: <20190508214128.20620-1-chaitanya.kulkarni@wdc.com>
 <20190508214201.GB8365@localhost.localdomain>
Message-ID: <SN6PR04MB45277F01185CE093ED40B3B386320@SN6PR04MB4527.namprd04.prod.outlook.com>

On 05/08/2019 02:47 PM, Keith Busch wrote:
> On Wed, May 08, 2019@02:41:28PM -0700, Chaitanya Kulkarni wrote:
>> This patch adds a helper function to check the nvme_ctrl state.
>> This helper function uses controller lock when accessing ctrl->state
>> member which is guarded in the nvme_change_ctrl_state().
>
> Does this really fix anything though? None of the readers prevent a
> state change after checking it.
>
Thanks Keith for quick review.

Couple of reason :-

1. Having one place where we guard the data and rest of the code
    seems to be accessing the same data without any locks weird to the
    eye, especially if controller's state is being read all over the
    different transports.

2. Possible scenario could be if a one thread trying to iterate
    through the subsytem's controller list something like
    nvme_active_ctrls() which is guarded by subsys->lock() :-
    nvme_init_identify()
     nvme_init_subsystem()
      nvme_active_ctrl()

    And another thread is trying to change the state e.g.
    NVME_CTRL_DELETING will result in race in nvme_active_ctrl() due
    to unguarded state variable access.

if need will look through the code, but this patch will definitely help 
avoid those scenarios if not exits right now.

Does that make sense ?
