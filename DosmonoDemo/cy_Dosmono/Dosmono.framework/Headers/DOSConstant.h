//
//  DOSConstant.h
//  Dosmono
//
//  Created by Sharp on 2020/7/27.
//  Copyright © 2020 shuanghoukj. All rights reserved.
//

#ifndef DOSConstant_h
#define DOSConstant_h

typedef NS_ENUM(NSInteger, DOSRecognizeAudioSource){

    DOSRecognizeAudioSource_mic = 0,//麦克风直接采集
    DOSRecognizeAudioSource_stream,//外部音频流输入

};

typedef NS_ENUM(NSInteger, DOSEncodeWay){

    DOSEncodeWay_WAV = 0,//wav
    DOSEncodeWay_MP3,//mp3

};

typedef NS_ENUM(NSUInteger, DOSLanguage){
    /*!
     * 普通话
     */
    DOSLanguage_MANDARIN = 0,
    /*!
     * 粤语
     */
    DOSLanguage_CANTONESE,
    /*!
     * 繁体中文
     */
    DOSLanguage_TRADITIONAL,
    /*!
     * 英语（美国）
    */
    DOSLanguage_EN_US,
};

typedef NS_ENUM(NSInteger, DOSBleFlag){

    DOSBleFlag_ELECTRICITY = 0,//获取电量 0~100%
    DOSBleFlag_MEMORY,//获取空间（返回总大小和剩余空间）返回值 remind_剩余空间G/M 或者 total_总空间G
    DOSBleFlag_FILE_LIST,//获取本地文件列表
    DOSBleFlag_DELETE_FILE,//删除文件 （返回成功或失败）
    DOSBleFlag_SN_NUMBER,//序列号
    DOSBleFlag_RECORD_STATUS,//获取录音状态 （0-正在录音、1-暂停、2-非录音，三种状态）
    DOSBleFlag_VERSION,//获取版本号
    DOSBleFlag_ACTIVE,//激活（录音第一次使用时，需要激活，否则不能使用录音功能）atcvice_success或active_fail
    DOSBleFlag_SYNC_TIME,//同步录音笔时间（开始录音之前需要同步一次时间，否则会返回录音笔初始时间）
    DOSBleFlag_START_RECORD,//录音开始，仅提供录音开始回调，主动开始录音请使用 - (void)startRecord:(DOSBleRecordBuilder *)builder;
    DOSBleFlag_FINISH_RECORD,//结束录音
    DOSBleFlag_STOP_RECORD,//暂停录音
    DOSBleFlag_STOP_TRANSFER, //停止上传数据
    DOSBleFlag_BTN_STATUS, //获取录音笔按钮状态
    DOSBleFlag_BTN_SETTING_DISABLE, //禁用录音笔按钮
    DOSBleFlag_BTN_SETTING_ENABLE, //启用录音笔按钮
    DOSBleFlag_BTN_SETTING, //录音笔按钮设置状态 0=失败，1=成功
};

typedef NS_ENUM(NSUInteger, DOSAudioFormat){

    DOSAudioFormat_AMR,
    DOSAudioFormat_MP3,
    DOSAudioFormat_WAV,
    DOSAudioFormat_PCM,
    DOSAudioFormat_UNKNOWN,
};


#endif /* DOSConstant_h */
