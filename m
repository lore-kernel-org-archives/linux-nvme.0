From: swise@opengridcomputing.com (Steve Wise)
Date: Fri, 12 Aug 2016 12:28:20 -0500
Subject: nvme_change_ctrl_state() bug?
Message-ID: <258e01d1f4be$ec094890$c41bd9b0$@opengridcomputing.com>


Shouldn't the assigning of the state be inside the lock?  

.
        spin_unlock_irq(&ctrl->lock);

        if (changed)
                ctrl->state = new_state;

        return changed;
