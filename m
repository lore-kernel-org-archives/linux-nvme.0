From: a.dawn@samsung.com (Arnav Dawn)
Date: Wed, 7 Jun 2017 16:17:18 +0530
Subject: [PATCH v2 2/2] nvme: Add support for FW activation without reset
In-Reply-To: <d480fd9e-b002-326d-1ee6-dd0f0694b4e1@grimberg.me>
References: <1496067391-26143-1-git-send-email-a.dawn@samsung.com>
 <CGME20170529141807epcas1p259e2e9b04327285d18f2d62bb6ccbce1@epcas1p2.samsung.com>
 <1496067498-26233-1-git-send-email-a.dawn@samsung.com>
 <d480fd9e-b002-326d-1ee6-dd0f0694b4e1@grimberg.me>
Message-ID: <b398fbce-8425-df4c-4bf2-6095c1da40b5@samsung.com>



On Tuesday 30 May 2017 05:08 PM, Sagi Grimberg wrote:
>
>
> On 29/05/17 17:18, Arnav Dawn wrote:
>>
>  

>> +        }
>> +        msleep(100);
>> +    }
>> +    nvme_start_queues(ctrl);
>> +    ctrl->fw_act_timeout = 0;
>
> Why is this needed?
>
Fw_act_timeout is reset to initial state once done.

>> +    log =  kmalloc(sizeof(struct nvme_fw_slot_info_log), GFP_KERNEL);
>> +    if (!log)
>> +        return;
>> +    if (nvme_get_log_page(ctrl, NVME_LOG_FW_SLOT, log))
>> +        dev_warn(ctrl->device,
>> +                "Get FW SLOT INFO log error\n");
>> +    kfree(log);
>> +}
>> +
>>  void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
>>          union nvme_result *res)
>>  {
>> @@ -2305,6 +2344,34 @@ void nvme_complete_async_event(struct
>> nvme_ctrl *ctrl, __le16 status,
>>          dev_info(ctrl->device, "rescanning\n");
>>          nvme_queue_scan(ctrl);
>>          break;
>> +    case NVME_AER_NOTICE_FW_ACT_STARTING:
>> +    {
>> +        u32 csts;
>> +
>> +        if (ctrl->ops->reg_read32(ctrl, NVME_REG_CSTS, &csts))
>> +            return;
>> +        if (ctrl->ops->reg_read32(ctrl, NVME_REG_CC,
>> +                    &ctrl->ctrl_config))
>> +            return;
>> +
>> +        if ((ctrl->ctrl_config & NVME_CC_ENABLE)
>> +                    && (csts & NVME_CSTS_PP)) {
>> +            if (ctrl->mtfa)
>> +                ctrl->fw_act_timeout = jiffies +
>> +                    msecs_to_jiffies(ctrl->mtfa * 100);
>> +            else
>> +                ctrl->fw_act_timeout = jiffies +
>> +                    msecs_to_jiffies(admin_timeout * 1000);
>> +
>> +            schedule_delayed_work(&ctrl->fw_act_work, 0);
>> +        }
>> +        break;
>> +    }
>> +    case NVME_AER_ERR_FW_IMG_LOAD:
>> +        dev_warn(ctrl->device, "FW image load error\n");
>> +        cancel_delayed_work(&ctrl->fw_act_work);
>> +        ctrl->fw_act_timeout = 0;
>
> Why is this needed?
In case of  fw load fail AER, fw_act_timeout is reset to initial state.

>> +        break;
>>      default:
>>          dev_warn(ctrl->device, "async event result %08x\n", result);
>>      }
>> @@ -2351,6 +2418,7 @@ void nvme_uninit_ctrl(struct nvme_ctrl *ctrl)
>>  {
>>      flush_work(&ctrl->async_event_work);
>>      flush_work(&ctrl->scan_work);
>> +    cancel_delayed_work(&ctrl->fw_act_work);
>
> Shouldn't this be cancel_delayed_work_sync?
>
yes it should be. Thank you.
>
>
Regards
Arnav Dawn
